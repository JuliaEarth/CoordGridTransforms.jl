allapprox(coords₁::C, coords₂::C; kwargs...) where {C<:CRS} =
  all(ntuple(i -> isapprox(getfield(coords₁, i), getfield(coords₂, i); kwargs...), nfields(coords₁)))

function allapprox(coords₁::C, coords₂::C; kwargs...) where {C<:Cartesian2D}
  isapprox(coords₁.x, coords₂.x, kwargs...) && isapprox(coords₁.y, coords₂.y, kwargs...)
end

function allapprox(coords₁::C, coords₂::C; kwargs...) where {C<:Cartesian3D}
  isapprox(coords₁.x, coords₂.x, kwargs...) &&
    isapprox(coords₁.y, coords₂.y, kwargs...) &&
    isapprox(coords₁.z, coords₂.z, kwargs...)
end

allapprox(coords₁::C, coords₂::C; kwargs...) where {C<:LatLon} =
  isapprox(coords₁.lat, coords₂.lat; kwargs...) && (
    isapprox(coords₁.lon, coords₂.lon; kwargs...) ||
    (isapproxlon180(coords₁.lon; kwargs...) && isapprox(coords₁.lon, -coords₂.lon; kwargs...))
  )

isapproxlon180(lon; kwargs...) = isapprox(abs(lon), 180°; kwargs...)
