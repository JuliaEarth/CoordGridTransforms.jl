# CoordGridTransforms.jl

[![][build-img]][build-url] [![][codecov-img]][codecov-url]

CoordGridTransforms.jl is a extension for the [CoordRefSystems.jl](https://github.com/JuliaEarth/CoordRefSystems.jl) package
that adds support grid transforms that require GeoTIFF files.
For now, only grids from the [PROJ CDN](https://cdn.proj.org/) are supported.

## Installation

Get the latest stable release with Julia's package manager:

```
] add CoordGridTransforms
```

## Usage

To use the conversions defined in CoordGridTransforms.jl, 
use it together with CoordRefSystems.jl in the same environment:

```julia
julia> using CoordRefSystems, CoordGridTransforms

julia> c = LatLon{SAD96}(-15, -45)
GeodeticLatLon{SAD96} coordinates
├─ lat: -15.0°
└─ lon: -45.0°

julia> convert(LatLon{SIRGAS2000}, c)
GeodeticLatLon{SIRGAS2000} coordinates
├─ lat: -15.000451566492272°
└─ lon: -45.00042666174454°
```

[build-img]: https://img.shields.io/github/actions/workflow/status/JuliaEarth/CoordGridTransforms.jl/CI.yml?branch=main&style=flat-square
[build-url]: https://github.com/JuliaEarth/CoordGridTransforms.jl/actions

[codecov-img]: https://img.shields.io/codecov/c/github/JuliaEarth/CoordGridTransforms.jl?style=flat-square
[codecov-url]: https://codecov.io/gh/JuliaEarth/CoordGridTransforms.jl
