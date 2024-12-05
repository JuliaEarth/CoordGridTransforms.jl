@testset "conversions" begin
  # Horizontal Grid Shift
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.5, Geographic Offset by Interpolation of Gridded Offset Data

  # NAD27 to NAD83
  c1 = LatLon{NAD27}(T(30), -T(90))
  c2 = convert(LatLon{NAD83}, c1)
  @test allapprox(c2, LatLon{NAD83}(T(30.000199294716566), T(-90.00007619090893)))

  # NAD27 to NAD83(CSRS)v2
  c1 = LatLon{NAD27}(T(50), -T(70))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(50.0000398581475), T(-69.999506322228)))

  c1 = LatLon{NAD27}(T(55), -T(65))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(55.00009359355559), T(-64.99919973281575)))

  # NAD27 to NAD83(CSRS)v3
  c1 = LatLon{NAD27}(T(43.6), -T(79.5))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(43.600055439398375), T(-79.49980272005197)))

  c1 = LatLon{NAD27}(T(43.8), -T(79.3))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(43.800054768403086), T(-79.29980046013165)))

  # SAD96 to SIRGAS2000
  c1 = LatLon{SAD96}(T(-15), T(-45))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-15.000451566492272), T(-45.00042666174454)))

  c1 = LatLon{SAD96}(T(-10), T(-40))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-10.000428915126209), T(-40.00037063898611)))
end
