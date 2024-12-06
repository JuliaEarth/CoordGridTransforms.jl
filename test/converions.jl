@testset "conversions" begin
  # Horizontal Grid Shift
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.5, Geographic Offset by Interpolation of Gridded Offset Data

  # Datum73 to ETRF (ETRS89)
  c1 = LatLon{Datum73}(T(40), T(-8))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.00081378249228), T(-7.999087263109144)))

  c1 = LatLon{Datum73}(T(40.5), T(-7.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.50082239831703), T(-7.499060090224424)))

  # DHDN to ETRF (ETRS89)
  c1 = LatLon{DHDN}(T(50), T(10))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(49.99884933991171), T(9.99882005851977)))

  c1 = LatLon{DHDN}(T(50.5), T(10.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(50.49879891349057), T(10.498740129905423)))

  # ED50 to ETRF (ETRS89)
  c1 = LatLon{ED50}(T(42), T(2))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(41.9988941048536), T(1.9988396626107727)))

  c1 = LatLon{ED50}(T(42.5), T(2.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(42.498911627264604), T(2.498850447396358)))

  # ISN93 to ISN2016
  c1 = LatLon{ISN93}(T(65), T(-19))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.00000469860723), T(-19.000005523900196)))

  c1 = LatLon{ISN93}(T(65.5), T(-18.5))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.50000484426457), T(-18.500005780253733)))

  # ISN2004 to ISN2016
  c1 = LatLon{ISN2004}(T(65), T(-19))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.0000026741597), T(-19.000002750801873)))

  c1 = LatLon{ISN2004}(T(65.5), T(-18.5))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.50000273493572), T(-18.500002761930126)))

  # Lisbon1937 to ETRF (ETRS89)
  c1 = LatLon{Lisbon1937}(T(40), T(-8))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.00160827147574), T(-8.001184937478962)))

  c1 = LatLon{Lisbon1937}(T(40.5), T(-7.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.501616799408936), T(-7.501167767618365)))

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

  # OSGB36 to ETRF (ETRS89)
  c1 = LatLon{OSGB36}(T(55), T(-3.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(55.00005596760369), T(-3.5013430674408594)))

  c1 = LatLon{OSGB36}(T(55.5), T(-2))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(55.500012794470535), T(-2.001564313021665)))

  # SAD96 to SIRGAS2000
  c1 = LatLon{SAD96}(T(-15), T(-45))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-15.000451566492272), T(-45.00042666174454)))

  c1 = LatLon{SAD96}(T(-10), T(-40))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-10.000428915126209), T(-40.00037063898611)))
end
