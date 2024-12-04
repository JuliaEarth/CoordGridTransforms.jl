@testset "conversions" begin
  # SAD96 to SIRGAS2000
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.5, Geographic Offset by Interpolation of Gridded Offset Data
  c1 = LatLon{SAD96}(T(-15), T(-45))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-15.000451566492272), T(-45.00042666174454)))

  c1 = LatLon{SAD96}(T(-10), T(-40))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-10.000428915126209), T(-40.00037063898611)))
end
