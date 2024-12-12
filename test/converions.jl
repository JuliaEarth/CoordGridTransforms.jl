@testset "conversions" begin
  # Horizontal Grid Shift
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.5, Geographic Offset by Interpolation of Gridded Offset Data

  # Datum73 to ETRF (ETRS89)
  c1 = LatLon{Datum73}(T(40), T(-8))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.00081355417707), T(-7.999086890966467)))

  c1 = LatLon{Datum73}(T(40.5), T(-7.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.500822285541446), T(-7.499059498822431)))

  # DHDN to ETRF (ETRS89)
  c1 = LatLon{DHDN}(T(50), T(10))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(49.998857302798164), T(9.998811455567678)))

  c1 = LatLon{DHDN}(T(50.5), T(10.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(50.4988057911396), T(10.498728909227584)))

  # ED50 to ETRF (ETRS89)
  c1 = LatLon{ED50}(T(42), T(2))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(41.99889344996876), T(1.9988412527243296)))

  c1 = LatLon{ED50}(T(42.5), T(2.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(42.49891144719389), T(2.4988522944185467)))

  # ISN93 to ISN2016
  c1 = LatLon{ISN93}(T(65), T(-19))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.00000470293945), T(-19.000005506975576)))

  c1 = LatLon{ISN93}(T(65.5), T(-18.5))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.50000484971433), T(-18.50000577601501)))

  # ISN2004 to ISN2016
  c1 = LatLon{ISN2004}(T(65), T(-19))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.00000267790941), T(-19.000002746851855)))

  c1 = LatLon{ISN2004}(T(65.5), T(-18.5))
  c2 = convert(LatLon{ISN2016}, c1)
  @test allapprox(c2, LatLon{ISN2016}(T(65.5000027383388), T(-18.50000276240546)))

  # Lisbon1937 to ETRF (ETRS89)
  c1 = LatLon{Lisbon1937}(T(40), T(-8))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.00160819249736), T(-8.001184268660833)))

  c1 = LatLon{Lisbon1937}(T(40.5), T(-7.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(40.50161713828449), T(-7.501167243650318)))

  # NAD27 to NAD83
  c1 = LatLon{NAD27}(T(30), T(-90))
  c2 = convert(LatLon{NAD83}, c1)
  @test allapprox(c2, LatLon{NAD83}(T(30.0002021077772), T(-90.00006962360607)))

  c1 = LatLon{NAD27}(T(35), T(-85))
  c2 = convert(LatLon{NAD83}, c1)
  @test allapprox(c2, LatLon{NAD83}(T(35.000075590552555), T(-84.99994750027855)))

  # NAD27 to NAD83(CSRS)v2
  c1 = LatLon{NAD27}(T(50), T(-70))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(50.0000388027769), T(-69.99950693332487)))

  c1 = LatLon{NAD27}(T(55), T(-65))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(55.00009247500036), T(-64.99919871389866)))

  # NAD27 to NAD83(CSRS)v3
  c1 = LatLon{NAD27}(T(43.6), T(-79.5))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(43.600055438888575), T(-79.4998027083277)))

  c1 = LatLon{NAD27}(T(43.8), T(-79.3))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(43.80005476944562), T(-79.2998004666633)))

  # NAD27 to NAD83(CSRS)v4
  c1 = LatLon{NAD27}(T(54.5), T(-126.2))
  c2 = convert(LatLon{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{4}}(T(54.499892979443075), T(-126.20167975558175)))

  c1 = LatLon{NAD27}(T(55.12), T(-121))
  c2 = convert(LatLon{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{4}}(T(55.119936973333026), T(-121.0014464963807)))

  # NAD83 to NAD83(CSRS)v2
  c1 = LatLon{NAD83}(T(53.95), T(-68))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(53.95000107333336), T(-68.00000158333332)))

  c1 = LatLon{NAD83}(T(45.9), T(-72.45))
  c2 = convert(LatLon{NAD83CSRS{2}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{2}}(T(45.89999938499998), T(-72.44999994255556)))

  # NAD83 to NAD83(CSRS)v3
  c1 = LatLon{NAD83}(T(49), T(-85.5))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(48.9999931805555), T(-85.50001148055514)))

  c1 = LatLon{NAD83}(T(42.16), T(-82.45))
  c2 = convert(LatLon{NAD83CSRS{3}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{3}}(T(42.159997325177805), T(-82.44999242513342)))

  # NAD83 to NAD83(CSRS)v4
  c1 = LatLon{NAD83}(T(54.5), T(-126.2))
  c2 = convert(LatLon{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{4}}(T(54.49999997222223), T(-126.20000173833333)))

  c1 = LatLon{NAD83}(T(54.08), T(-128.66))
  c2 = convert(LatLon{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLon{NAD83CSRS{4}}(T(54.079998935382235), T(-128.66000092432887)))

  # OSGB36 to ETRF (ETRS89)
  c1 = LatLon{OSGB36}(T(55), T(-3.5))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(55.00005659972214), T(-3.501344154410892)))

  c1 = LatLon{OSGB36}(T(55.5), T(-2))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(55.50001349305527), T(-2.0015656316280364)))

  # PD/83 to ETRF (ETRS89)
  c1 = LatLon{PD83}(T(50.94), T(11.25))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(50.93875928335719), T(11.248613153855006)))

  c1 = LatLon{PD83}(T(51.14), T(11.45))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(51.138737511105006), T(11.448580215003755)))

  # RD/83 to ETRF (ETRS89)
  c1 = LatLon{RD83}(T(52.25), T(12.75))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(52.24861670891444), T(12.748358176151912)))

  c1 = LatLon{RD83}(T(50.5), T(12.65))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test allapprox(c2, LatLon{ETRFLatest}(T(50.4988229786555), T(12.648406205177308)))

  # SAD96 to SIRGAS2000
  c1 = LatLon{SAD96}(T(-15), T(-45))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-15.000452247228887), T(-45.00042616943518)))

  c1 = LatLon{SAD96}(T(-10), T(-40))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test allapprox(c2, LatLon{SIRGAS2000}(T(-10.000429661108388), T(-40.000369772215684)))

  # Point Motion with Velocity Grids
  # note: the results differ from PROJ because we use the standard implementation described
  # in the EPSG Guidance Note 7-2, Section 4.4.6, Geographic Offset by Interpolation of Gridded Velocity Data

  # NAD83(CSRS)v3 to NAD83(CSRS)v4
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{4}}(T(59.999999938645644), T(-89.99999975269422), T(1.0371961307525634)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{4}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{4}}(T(64.99999994769557), T(-84.99999974497726), T(1.0369444847106934)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v6
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(59.99999984047868), T(-89.99999935700498), T(1.096709939956665)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(64.99999986400846), T(-84.99999933694087), T(1.0960556602478027)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v7
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(59.99999984047868), T(-89.99999935700498), T(1.096709939956665)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(64.99999986400846), T(-84.99999933694087), T(1.0960556602478027)))

  # NAD83(CSRS)v3 to NAD83(CSRS)v8
  c1 = LatLonAlt{NAD83CSRS{3}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(59.99999984047868), T(-89.99999935700498), T(1.096709939956665)))

  c1 = LatLonAlt{NAD83CSRS{3}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(64.99999986400846), T(-84.99999933694087), T(1.0960556602478027)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v6
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(59.99999990183303), T(-89.99999960431076), T(1.0595138092041017)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{6}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{6}}(T(64.99999991631289), T(-84.99999959196361), T(1.0591111755371094)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v7
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(59.99999990183303), T(-89.99999960431076), T(1.0595138092041017)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{7}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{7}}(T(64.99999991631289), T(-84.99999959196361), T(1.0591111755371094)))

  # NAD83(CSRS)v4 to NAD83(CSRS)v8
  c1 = LatLonAlt{NAD83CSRS{4}}(T(60), T(-90), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(59.99999990183303), T(-89.99999960431076), T(1.0595138092041017)))

  c1 = LatLonAlt{NAD83CSRS{4}}(T(65), T(-85), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{8}}, c1)
  @test allapprox(c2, LatLonAlt{NAD83CSRS{8}}(T(64.99999991631289), T(-84.99999959196361), T(1.0591111755371094)))

  # NTF to RGF93v1
  c1 = LatLon{NTF}(T(48), T(2))
  c2 = convert(LatLon{RGF93v1}, c1)
  @test allapprox(c2, LatLon{RGF93v1}(T(47.99993607658557), T(1.9992829984694425)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  # example from  EPSG Guidance Note 7-2, Section 4.4.1.3, Geocentric translations by grid interpolation (France)
  c1 = LatLon{NTF}(T(48.84451225), T(2.4256718611111108))
  c2 = convert(LatLon{RGF93v1}, c1)
  @test allapprox(c2, LatLon{RGF93v1}(T(48.84444583333334), T(2.4249711111111107)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  # NTF to RGF93v2
  c1 = LatLon{NTF}(T(48), T(2))
  c2 = convert(LatLon{RGF93v2}, c1)
  @test allapprox(c2, LatLon{RGF93v2}(T(47.99993607658557), T(1.9992829984694425)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  c1 = LatLon{NTF}(T(48.84451225), T(2.4256718611111108))
  c2 = convert(LatLon{RGF93v2}, c1)
  @test allapprox(c2, LatLon{RGF93v2}(T(48.84444583333334), T(2.4249711111111107)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  # NTF to RGF93v2b
  c1 = LatLon{NTF}(T(48), T(2))
  c2 = convert(LatLon{RGF93v2b}, c1)
  @test allapprox(c2, LatLon{RGF93v2b}(T(47.99993607658557), T(1.9992829984694425)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  c1 = LatLon{NTF}(T(48.84451225), T(2.4256718611111108))
  c2 = convert(LatLon{RGF93v2b}, c1)
  @test allapprox(c2, LatLon{RGF93v2b}(T(48.84444583333334), T(2.4249711111111107)))
  c3 = convert(LatLon{NTF}, c2)
  @test allapprox(c3, c1)

  # coordinates outside the grid bounds
  # hgridshift
  c1 = LatLon{SAD96}(T(10), T(-10))
  c2 = convert(LatLon{SIRGAS2000}, c1)
  @test c2.lat ≈ c1.lat
  @test c2.lon ≈ c1.lon

  c1 = LatLon{RD83}(T(65), T(25))
  c2 = convert(LatLon{ETRFLatest}, c1)
  @test c2.lat ≈ c1.lat
  @test c2.lon ≈ c1.lon

  # pointmotion
  c1 = LatLonAlt{NAD83CSRS{3}}(T(90), T(10), T(1))
  c2 = convert(LatLonAlt{NAD83CSRS{4}}, c1)
  @test c2.lat ≈ c1.lat
  @test c2.lon ≈ c1.lon
  @test c2.alt ≈ c1.alt

  # geocgridtranslation
  c1 = convert(Cartesian, LatLon{NTF}(T(65), T(25)))
  c2 = convert(Cartesian{RGF93v1}, c1)
  @test c2.x ≈ c1.x
  @test c2.y ≈ c1.y
  @test c2.z ≈ c1.z
end
