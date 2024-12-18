# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    @pointmotion Datumₛ Datumₜ

Point Motion transform that moves points based on interpolated velocities.

## References

* Section 4.4.6 of EPSG Guidance Note 7-2: <https://epsg.org/guidance-notes.html>
"""
macro pointmotion(Datumₛ, Datumₜ)
  expr = quote
    function Base.convert(::Type{LatLonAlt{Dₜ}}, coords::LatLonAlt{Dₛ}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      latlonalt = (coords.lat, coords.lon, coords.alt)
      latlonalt′ = pointmotionfwd(Dₛ, Dₜ, latlonalt)
      LatLonAlt{Dₜ}(latlonalt′...)
    end

    function Base.convert(::Type{LatLonAlt{Dₛ}}, coords::LatLonAlt{Dₜ}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      latlonalt = (coords.lat, coords.lon, coords.alt)
      latlonalt′ = pointmotionbwd(Dₛ, Dₜ, latlonalt)
      LatLonAlt{Dₛ}(latlonalt′...)
    end
  end
  esc(expr)
end

function pointmotionfwd(Datumₛ, Datumₜ, (lat, lon, alt))
  λ = ustrip(deg2rad(lon))
  ϕ = ustrip(deg2rad(lat))
  h = ustrip(m, alt)

  λₛ, ϕₛ, hₛ = pointmotionparams(Datumₛ, Datumₜ, lat, lon, ϕ, h)
  λ′ = λ + λₛ
  ϕ′ = ϕ + ϕₛ
  h′ = h + hₛ

  # https://github.com/PainterQubits/Unitful.jl/issues/753
  lon′ = rad2deg(λ′) * °
  lat′ = rad2deg(ϕ′) * °
  alt′ = uconvert(unit(alt), h′ * m)

  lat′, lon′, alt′
end

# Adapted from PROJ coordinate transformation software
# Initial PROJ 4.3 public domain code was put as Frank Warmerdam as copyright
# holder, but he didn't mean to imply he did the work. Essentially all work was
# done by Gerald Evenden.

# reference code: https://github.com/OSGeo/PROJ/blob/master/src/grids.cpp

function pointmotionbwd(Datumₛ, Datumₜ, (lat, lon, alt))
  λ = ustrip(deg2rad(lon))
  ϕ = ustrip(deg2rad(lat))
  h = ustrip(m, alt)
  tol = atol(λ)

  # initial guess
  λₛ, ϕₛ, hₛ = pointmotionparams(Datumₛ, Datumₜ, lat, lon, ϕ, h)
  λᵢ = λ - λₛ
  ϕᵢ = ϕ - ϕₛ
  hᵢ = h - hₛ
  for _ in 1:MAXITER
    # to check if the guess is equivalent to the original Datumₛ coordinates,
    # forward the guess coordinates to compare them with the Datumₜ input coordinates
    latᵢ = rad2deg(ϕᵢ) * °
    lonᵢ = rad2deg(λᵢ) * °
    λᵢₛ, ϕᵢₛ, hᵢₛ = pointmotionparams(Datumₛ, Datumₜ, latᵢ, lonᵢ, ϕᵢ, hᵢ)
    λᵢ′ = λᵢ + λᵢₛ
    ϕᵢ′ = ϕᵢ + ϕᵢₛ
    hᵢ′ = hᵢ + hᵢₛ
    # difference between forward coordinates and input coordinates for comparison
    λΔ = λᵢ′ - λ
    ϕΔ = ϕᵢ′ - ϕ
    hΔ = hᵢ′ - h
    # if the difference is small, stop the iteration
    if hypot(λΔ, ϕΔ, hΔ) ≤ tol
      break
    end
    # otherwise, subtract the difference and continue
    λᵢ -= λΔ
    ϕᵢ -= ϕΔ
    hᵢ -= hΔ
  end

  # https://github.com/PainterQubits/Unitful.jl/issues/753
  lonᵢ = rad2deg(λᵢ) * °
  latᵢ = rad2deg(ϕᵢ) * °
  altᵢ = uconvert(unit(alt), hᵢ * m)

  latᵢ, lonᵢ, altᵢ
end

function pointmotionparams(Datumₛ, Datumₜ, lat, lon, ϕ, h)
  🌎 = ellipsoid(Datumₛ)
  T = numtype(lon)
  a = T(ustrip(m, majoraxis(🌎)))
  e² = T(eccentricity²(🌎))

  itp = interpolatelatlon(Datumₛ, Datumₜ, lat, lon)
  # type assertion is necessary for type stability
  # convert millimeters to meters
  eᵥ::T = T(itp[1]) / 1000
  nᵥ::T = T(itp[2]) / 1000
  uᵥ::T = T(itp[3]) / 1000

  # ENU velocities to geodetic velocities
  N = sqrt(1 - e² * sin(ϕ)^2)
  ρ = (a * (1 - e²)) / N^3
  ν = a / N

  λᵥ = eᵥ / ((ν + h) * cos(ϕ))
  ϕᵥ = nᵥ / (ρ + h)
  hᵥ = uᵥ

  # shift parameters
  t = T(epoch(Datumₜ) - epoch(Datumₛ))
  λₛ = t * λᵥ
  ϕₛ = t * ϕᵥ
  hₛ = t * hᵥ

  λₛ, ϕₛ, hₛ
end
