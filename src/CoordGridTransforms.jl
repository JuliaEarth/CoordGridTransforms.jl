# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

module CoordGridTransforms

using CoordRefSystems

using Unitful: °
using Unitful: numtype, ustrip
using StaticArrays: SVector, SA
using MappedArrays: mappedarray
using Interpolations: interpolate, Gridded, Linear
using DataDeps: @datadep_str, register, DataDep

import GeoTIFF

function __init__()
  # make sure datasets are always downloaded
  # without user interaction from DataDeps.jl
  ENV["DATADEPS_ALWAYS_ACCEPT"] = true
end

include("grids.jl")
include("transforms.jl")

end
