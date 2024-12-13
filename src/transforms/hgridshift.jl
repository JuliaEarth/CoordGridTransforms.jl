# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    @hgridshift Datumₛ Datumₜ

Horizontal Grid Shift transform that uses grid interpolation
to calculate coordinate offsets.

## References

* Section 4.4.5 of EPSG Guidance Note 7-2: <https://epsg.org/guidance-notes.html>
"""
macro hgridshift(Datumₛ, Datumₜ)
  expr = quote
    function Base.convert(::Type{LatLon{Dₜ}}, coords::LatLon{Dₛ}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      latlon = (coords.lat, coords.lon)
      latlon′ = hgridshiftfwd(Dₛ, Dₜ, latlon)
      LatLon{Dₜ}(latlon′...)
    end

    function Base.convert(::Type{LatLon{Dₛ}}, coords::LatLon{Dₜ}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      latlon = (coords.lat, coords.lon)
      latlon′ = hgridshiftbwd(Dₛ, Dₜ, latlon)
      LatLon{Dₛ}(latlon′...)
    end
  end
  esc(expr)
end

function hgridshiftfwd(Datumₛ, Datumₜ, (lat, lon))
  latshift, lonshift = hgridshiftparams(Datumₛ, Datumₜ, lat, lon)
  lat + latshift, lon + lonshift
end

# Adapted from PROJ coordinate transformation software
# Initial PROJ 4.3 public domain code was put as Frank Warmerdam as copyright
# holder, but he didn't mean to imply he did the work. Essentially all work was
# done by Gerald Evenden.

# reference code: https://github.com/OSGeo/PROJ/blob/master/src/grids.cpp

function hgridshiftbwd(Datumₛ, Datumₜ, (lat, lon))
  tol = atol(numtype(lon))
  # initial guess
  latshift, lonshift = hgridshiftparams(Datumₛ, Datumₜ, lat, lon)
  latᵢ = lat - latshift
  lonᵢ = lon - lonshift
  for _ in 1:MAXITER
    # to check if the guess is equivalent to the original Datumₛ coordinates,
    # forward the guess coordinates to compare them with the Datumₜ input coordinates
    latᵢ′, lonᵢ′ = hgridshiftfwd(Datumₛ, Datumₜ, (latᵢ, lonᵢ))
    # difference between forward coordinates and input coordinates for comparison
    latΔ = latᵢ′ - lat
    lonΔ = lonᵢ′ - lon
    # if the difference is small, stop the iteration
    if hypot(latΔ, lonΔ) ≤ tol
      break
    end
    # otherwise, subtract the difference and continue
    latᵢ -= latΔ
    lonᵢ -= lonΔ
  end
  latᵢ, lonᵢ
end

function hgridshiftparams(Datumₛ, Datumₜ, lat, lon)
  T = numtype(lon)
  itp = interpolatelatlon(Datumₛ, Datumₜ, lat, lon)
  # type assertion is necessary for type stability
  latshift::T = T(itp[1])
  lonshift::T = T(itp[2])
  # convert arc seconds to degrees
  latshift′ = latshift / 3600 * °
  lonshift′ = lonshift / 3600 * °
  latshift′, lonshift′
end
