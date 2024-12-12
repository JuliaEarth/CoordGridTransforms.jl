# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    @geocgridtranslation Datumₛ Datumₜ (δx=0.0, δy=0.0, δz=0.0)

Geocentric translation by grid interpolation with
standard translation parameters `δx, δy, δz` in meters.

## References

* Section 4.4.1.3 of EPSG Guidance Note 7-2: <https://epsg.org/guidance-notes.html>
"""
macro geocgridtranslation(Datumₛ, Datumₜ, params)
  expr = quote
    function Base.convert(::Type{Cartesian{Dₜ}}, coords::Cartesian{Dₛ,3}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      xyz = SVector(coords.x, coords.y, coords.z)
      xyz′ = geocgridtranslationfwd(Dₛ, Dₜ, xyz; $params...)
      Cartesian{Dₜ}(xyz′...)
    end

    function Base.convert(::Type{Cartesian{Dₛ}}, coords::Cartesian{Dₜ,3}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      xyz = SVector(coords.x, coords.y, coords.z)
      xyz′ = geocgridtranslationbwd(Dₛ, Dₜ, xyz)
      Cartesian{Dₛ}(xyz′...)
    end
  end
  esc(expr)
end

function geocgridtranslationfwd(Datumₛ, Datumₜ, xyz; δx=0.0, δy=0.0, δz=0.0)
  T = numtype(eltype(xyz))
  # standard translation
  δ′ = SVector(T(δx) * m, T(δy) * m, T(δz) * m)
  # approximated target coordinates
  xyz′ = xyz + δ′
  δ = geocgridtranslationparams(Datumₛ, Datumₜ, xyz′)
  xyz + δ
end

function geocgridtranslationbwd(Datumₛ, Datumₜ, xyz)
  δ = geocgridtranslationparams(Datumₛ, Datumₜ, xyz)
  xyz - δ
end

function geocgridtranslationparams(Datumₛ, Datumₜ, xyz)
  T = numtype(eltype(xyz))
  # target latlon coordinates for interpolation
  latlon = convert(LatLon, Cartesian{Datumₜ}(xyz...))
  itp = interpolatelatlon(Datumₛ, Datumₜ, latlon.lat, latlon.lon)
  # type assertion is necessary for type stability
  δx::T = T(itp[1])
  δy::T = T(itp[2])
  δz::T = T(itp[3])
  SVector(T(δx) * m, T(δy) * m, T(δz) * m)
end
