# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    @francetranslation Datumₛ Datumₜ (δx=0.0, δy=0.0, δz=0.0)

Geocentric translation by grid interpolation used in France, 
with standard translation parameters `δx, δy, δz` in meters.

## References

* Section 4.4.1.3 of EPSG Guidance Note 7-2: <https://epsg.org/guidance-notes.html>
"""
macro francetranslation(Datumₛ, Datumₜ, params)
  expr = quote
    function Base.convert(::Type{Cartesian{Dₜ}}, coords::Cartesian{Dₛ,3}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      xyz = SVector(coords.x, coords.y, coords.z)
      xyz′ = francetranslationfwd(Dₛ, Dₜ, xyz; $params...)
      Cartesian{Dₜ}(xyz′...)
    end

    function Base.convert(::Type{Cartesian{Dₛ}}, coords::Cartesian{Dₜ,3}) where {Dₛ<:$Datumₛ,Dₜ<:$Datumₜ}
      xyz = SVector(coords.x, coords.y, coords.z)
      xyz′ = francetranslationbwd(Dₛ, Dₜ, xyz)
      Cartesian{Dₛ}(xyz′...)
    end
  end
  esc(expr)
end

function francetranslationfwd(Datumₛ, Datumₜ, xyz; δx=0.0, δy=0.0, δz=0.0)
  T = numtype(eltype(xyz))
  # standard translation
  δ′ = SVector(T(δx) * m, T(δy) * m, T(δz) * m)
  # approximated target coordinates
  xyz′ = xyz + δ′
  δ = francetranslationparams(Datumₛ, Datumₜ, xyz′)
  xyz + δ
end

function francetranslationbwd(Datumₛ, Datumₜ, xyz)
  δ = francetranslationparams(Datumₛ, Datumₜ, xyz)
  xyz - δ
end

function francetranslationparams(Datumₛ, Datumₜ, xyz)
  T = numtype(eltype(xyz))
  # target latlon coordinates for interpolation
  latlon = convert(LatLon, Cartesian{Datumₜ}(xyz...))
  interp = interpolator(Datumₛ, Datumₜ)
  itp = interp(ustrip(latlon.lon), ustrip(latlon.lat))
  # type assertion is necessary for type stability
  δx::T = T(itp[1])
  δy::T = T(itp[2])
  δz::T = T(itp[3])
  SVector(T(δx) * m, T(δy) * m, T(δz) * m)
end
