using CoordGridTransforms
using CoordRefSystems
using Test

using Unitful: °

# environment settings
isCI = "CI" ∈ keys(ENV)
islinux = Sys.islinux()
visualtests = !isCI || (isCI && islinux)
datadir = joinpath(@__DIR__, "data")

# float settings
T = if isCI
  if ENV["FLOAT_TYPE"] == "Float32"
    Float32
  elseif ENV["FLOAT_TYPE"] == "Float64"
    Float64
  end
else
  Float64
end

testfiles = ["conversions.jl"]

@testset "CoordGridTransforms.jl" begin
  for testfile in testfiles
    println("Testing $testfile...")
    include(testfile)
  end
end
