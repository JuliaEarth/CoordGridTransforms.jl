# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

module CoordGridTransforms

using CoordRefSystems

using Unitful: m, °
using Unitful: unit, numtype
using Unitful: uconvert, ustrip
using StaticArrays: SVector, SA
using MappedArrays: mappedarray
using Interpolations: interpolate, Gridded, Linear, bounds
using DataDeps: @datadep_str, register, DataDep

import GeoTIFF

function __init__()
  # make sure datasets are always downloaded
  # without user interaction from DataDeps.jl
  ENV["DATADEPS_ALWAYS_ACCEPT"] = true
end

include("utils.jl")
include("grids.jl")
include("transforms.jl")

end
