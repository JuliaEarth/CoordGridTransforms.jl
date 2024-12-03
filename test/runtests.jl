using CoordGridTransforms
using CoordRefSystems
using Test

include("testutils.jl")

testfiles = ["converions.jl"]

# --------------------------------
# RUN TESTS WITH SINGLE PRECISION
# --------------------------------

T = Float32
@testset "CoordGridTransforms.jl ($T)" begin
  for testfile in testfiles
    println("Testing $testfile...")
    include(testfile)
  end
end

# --------------------------------
# RUN TESTS WITH DOUBLE PRECISION
# --------------------------------

T = Float64
@testset "CoordGridTransforms.jl ($T)" begin
  for testfile in testfiles
    println("Testing $testfile...")
    include(testfile)
  end
end