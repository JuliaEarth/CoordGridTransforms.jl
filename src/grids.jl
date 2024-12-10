# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    geotiff(Datumₛ, Datumₜ)

GeoTIFF file used in transforms that convert source `Datumₛ` to target `Datumₜ`.
"""
function geotiff end

# cache interpolator objects to avoid interpolating the same grid twice
const INTERPOLATOR = IdDict()

"""
    interpolator(Datumₛ, Datumₜ)

Linear interpolation of GeoTIFF grid that converts `Datumₛ` to `Datumₜ`.
All of the GeoTIFF channels are combined into the interpolated grid as a vector.
"""
function interpolator(Datumₛ, Datumₜ)
  if haskey(INTERPOLATOR, (Datumₛ, Datumₜ))
    return INTERPOLATOR[(Datumₛ, Datumₜ)]
  end

  # download geotiff from PROJ CDN
  file = downloadgeotiff(Datumₛ, Datumₜ)
  geotiff = GeoTIFF.load(file)

  # construct the interpolation grid
  img = GeoTIFF.image(geotiff)
  grid = mappedarray(img) do color
    N = GeoTIFF.nchannels(color)
    tup = ntuple(i -> GeoTIFF.channel(color, i), N)
    SVector(tup)
  end

  # lon lat range
  m, n = size(grid)
  A, b = GeoTIFF.affineparams2D(GeoTIFF.metadata(geotiff))
  # PixelIsPoint convention
  lon₀, lat₀ = muladd(A, SA[0, 0], b)
  lonₘ, latₙ = muladd(A, SA[m - 1, n - 1], b)

  # Interpolations.jl requires ordered ranges
  reverselon = lon₀ > lonₘ
  reverselat = lat₀ > latₙ
  lonₛ, lonₑ = reverselon ? (lonₘ, lon₀) : (lon₀, lonₘ)
  latₛ, latₑ = reverselat ? (latₙ, lat₀) : (lat₀, latₙ)
  lonrange = range(start=lonₛ, stop=lonₑ, length=m)
  latrange = range(start=latₛ, stop=latₑ, length=n)

  # reverse dimensions if range is reversed
  if reverselon
    grid = @view grid[m:-1:1, :]
  end

  if reverselat
    grid = @view grid[:, n:-1:1]
  end

  # create the interpolation
  interp = interpolate((lonrange, latrange), grid, Gridded(Linear()))

  INTERPOLATOR[(Datumₛ, Datumₜ)] = interp

  interp
end

"""
    downloadgeotiff(Datumₛ, Datumₜ)

Download the GeoTIFF file that converts `Datumₛ` to `Datumₜ` from PROJ CDN.
"""
function downloadgeotiff(Datumₛ, Datumₜ)
  fname = geotiff(Datumₛ, Datumₜ)
  url = "https://cdn.proj.org/$fname"
  ID = splitext(fname) |> first

  dir = try
    # if data is already on disk
    # we just return the path
    @datadep_str ID
  catch
    # otherwise we register the data
    # and download using DataDeps.jl
    try
      register(DataDep(ID, "Grid file provided by PROJ CDN", url, Any))
      @datadep_str ID
    catch
      throw(ErrorException("download failed due to internet and/or server issues"))
    end
  end

  # file path
  joinpath(dir, fname)
end

# ----------------
# IMPLEMENTATIONS
# ----------------

geotiff(::Type{Datum73}, ::Type{<:ETRF}) = "pt_dgt_D73_ETRS89_geo.tif"

geotiff(::Type{DHDN}, ::Type{<:ETRF}) = "de_adv_BETA2007.tif"

geotiff(::Type{ED50}, ::Type{<:ETRF}) = "es_cat_icgc_100800401.tif"

geotiff(::Type{ISN93}, ::Type{ISN2016}) = "is_lmi_ISN93_ISN2016.tif"

geotiff(::Type{ISN2004}, ::Type{ISN2016}) = "is_lmi_ISN2004_ISN2016.tif"

geotiff(::Type{Lisbon1937}, ::Type{<:ETRF}) = "pt_dgt_DLx_ETRS89_geo.tif"

geotiff(::Type{NAD27}, ::Type{NAD83}) = "us_noaa_conus.tif"

geotiff(::Type{NAD27}, ::Type{NAD83CSRS{2}}) = "ca_nrc_NA27SCRS.tif"

geotiff(::Type{NAD27}, ::Type{NAD83CSRS{3}}) = "ca_nrc_TO27CSv1.tif"

# TODO: unsupported GeoTIFF format: StridedTaggedImage
# geotiff(::Type{NAD27}, ::Type{NAD83CSRS{4}}) = "ca_nrc_BC_27_05.tif"

# geotiff(::Type{NAD83}, ::Type{NAD83CSRS{2}}) = "ca_nrc_NA83SCRS.tif"

# geotiff(::Type{NAD83}, ::Type{NAD83CSRS{3}}) = "ca_nrc_ON83CSv1.tif"

# geotiff(::Type{NAD83}, ::Type{NAD83CSRS{4}}) = "ca_nrc_BC_93_05.tif"

# TODO: grid files not found in PROJ CDN
# geotiff(::Type{NAD83}, ::Type{NAD83CSRS{6}}) = ""

# geotiff(::Type{NAD83}, ::Type{NAD83CSRS{7}}) = ""

geotiff(::Type{NAD83CSRS{3}}, ::Type{NAD83CSRS{4}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{3}}, ::Type{NAD83CSRS{6}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{3}}, ::Type{NAD83CSRS{7}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{3}}, ::Type{NAD83CSRS{8}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{4}}, ::Type{NAD83CSRS{6}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{4}}, ::Type{NAD83CSRS{7}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NAD83CSRS{4}}, ::Type{NAD83CSRS{8}}) = "ca_nrc_NAD83v70VG.tif"

geotiff(::Type{NTF}, ::Type{RGF93v1}) = "fr_ign_gr3df97a.tif"

geotiff(::Type{NTF}, ::Type{RGF93v2}) = "fr_ign_gr3df97a.tif"

geotiff(::Type{NTF}, ::Type{RGF93v2b}) = "fr_ign_gr3df97a.tif"

geotiff(::Type{OSGB36}, ::Type{<:ETRF}) = "uk_os_OSTN15_NTv2_OSGBtoETRS.tif"

# TODO: unsupported GeoTIFF format: StridedTaggedImage
# geotiff(::Type{RD83}, ::Type{<:ETRF}) = "de_geosn_NTv2_SN.tif"

geotiff(::Type{SAD69}, ::Type{SIRGAS2000}) = "br_ibge_SAD69_003.tif"

geotiff(::Type{SAD96}, ::Type{SIRGAS2000}) = "br_ibge_SAD96_003.tif"
