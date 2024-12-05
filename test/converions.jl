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

  # Point Motion with Velocity Grids
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.6, Geographic Offset by Interpolation of Gridded Velocity Data

  # NAD83(CSRS)v3 to NAD83(CSRS)v4
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{4}}(T(59.999999938434975), T(-89.99999975034973), T(1.037781248477583)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{4}}(T(64.99999994796659), T(-84.99999974705766), T(1.0365328033839258)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v6
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(59.999999839930936), T(-89.99999935090928), T(1.098231246041716)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(64.99999986471312), T(-84.99999934234988), T(1.0949852887982072)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v7
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(59.999999839930936), T(-89.99999935090928), T(1.098231246041716)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(64.99999986471312), T(-84.99999934234988), T(1.0949852887982072)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v8
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(59.999999839930936), T(-89.99999935090928), T(1.098231246041716)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(64.99999986471312), T(-84.99999934234988), T(1.0949852887982072)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v6
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(59.99999990149597), T(-89.99999960055956), T(1.060449997564133)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(64.99999991674655), T(-84.99999959529225), T(1.0584524854142814)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v7
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(59.99999990149597), T(-89.99999960055956), T(1.060449997564133)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(64.99999991674655), T(-84.99999959529225), T(1.0584524854142814)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v8
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(59.99999990149597), T(-89.99999960055956), T(1.060449997564133)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(64.99999991674655), T(-84.99999959529225), T(1.0584524854142814)))
end
