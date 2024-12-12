# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

include("transforms/hgridshift.jl")
include("transforms/pointmotion.jl")
include("transforms/geocgridtranslation.jl")

# ----------------
# IMPLEMENTATIONS
# ----------------

# Adapted from PROJ coordinate transformation software
# Initial PROJ 4.3 public domain code was put as Frank Warmerdam as copyright
# holder, but he didn't mean to imply he did the work. Essentially all work was
# done by Gerald Evenden.

# source of parameters: 
# EPSG Database: https://epsg.org/search/by-name
# PROJ source code: https://github.com/OSGeo/PROJ/blob/master/src/datums.cpp

# https://epsg.org/transformation_6189/Datum-73-to-ETRS89-6.html
@hgridshift Datum73 ETRF

# https://epsg.org/transformation_15948/DHDN-to-ETRS89-8.html
@hgridshift DHDN ETRF

# https://epsg.org/transformation_5661/ED50-to-ETRS89-14.html
@hgridshift ED50 ETRF

# https://epsg.org/transformation_9232/ISN93-to-ISN2016-1.html
@hgridshift ISN93 ISN2016

# https://epsg.org/transformation_9233/ISN2004-to-ISN2016-1.html
@hgridshift ISN2004 ISN2016

# https://epsg.org/transformation_6188/Lisbon-to-ETRS89-4.html
@hgridshift Lisbon1937 ETRF

# https://epsg.org/transformation_1241/NAD27-to-NAD83-1.html
@hgridshift NAD27 NAD83

# https://epsg.org/transformation_9239/NAD27-to-NAD83-CSRS-v2-1.html
@hgridshift NAD27 NAD83CSRS{2}

# https://epsg.org/transformation_9107/NAD27-to-NAD83-CSRS-v3-5.html
@hgridshift NAD27 NAD83CSRS{3}

# https://epsg.org/transformation_9115/NAD27-to-NAD83-CSRS-v4-10.html
@hgridshift NAD27 NAD83CSRS{4}

# https://epsg.org/transformation_9241/NAD83-to-NAD83-CSRS-v2-1.html
@hgridshift NAD83 NAD83CSRS{2}

# https://epsg.org/transformation_9110/NAD83-to-NAD83-CSRS-v3-5.html
@hgridshift NAD83 NAD83CSRS{3}

# https://epsg.org/transformation_9119/NAD83-to-NAD83-CSRS-v4-9.html
@hgridshift NAD83 NAD83CSRS{4}

# https://epsg.org/transformation_7709/OSGB36-to-ETRS89-2.html
@hgridshift OSGB36 ETRF

# https://epsg.org/transformation_10677/PD-83-to-ETRS89-2.html
@hgridshift PD83 ETRF

# https://epsg.org/transformation_6948/RD-83-to-ETRS89-2.html
@hgridshift RD83 ETRF

# https://epsg.org/transformation_5529/SAD69-96-to-SIRGAS-2000-1.html
@hgridshift SAD96 SIRGAS2000

# https://epsg.org/transformation_10528/NAD83-CSRS-v3-to-NAD83-CSRS-v4-3.html
@pointmotion NAD83CSRS{3} NAD83CSRS{4}

# https://epsg.org/transformation_10530/NAD83-CSRS-v3-to-NAD83-CSRS-v6-3.html
@pointmotion NAD83CSRS{3} NAD83CSRS{6}

# https://epsg.org/transformation_10534/NAD83-CSRS-v3-to-NAD83-CSRS-v7-2.html
@pointmotion NAD83CSRS{3} NAD83CSRS{7}

# https://epsg.org/transformation_10535/NAD83-CSRS-v3-to-NAD83-CSRS-v8-2.html
@pointmotion NAD83CSRS{3} NAD83CSRS{8}

# https://epsg.org/transformation_10537/NAD83-CSRS-v4-to-NAD83-CSRS-v6-3.html
@pointmotion NAD83CSRS{4} NAD83CSRS{6}

# https://epsg.org/transformation_10538/NAD83-CSRS-v4-to-NAD83-CSRS-v7-2.html
@pointmotion NAD83CSRS{4} NAD83CSRS{7}

# https://epsg.org/transformation_10539/NAD83-CSRS-v4-to-NAD83-CSRS-v8-2.html
@pointmotion NAD83CSRS{4} NAD83CSRS{8}

# https://epsg.org/transformation_9327/NTF-to-RGF93-v1-1.html
@geocgridtranslation NTF RGF93v1 (δx=-168.0, δy=-60.0, δz=320.0)

# https://epsg.org/transformation_9888/NTF-to-RGF93-v2-1.html
@geocgridtranslation NTF RGF93v2 (δx=-168.0, δy=-60.0, δz=320.0)

# https://epsg.org/transformation_9889/NTF-to-RGF93-v2b-1.html
@geocgridtranslation NTF RGF93v2b (δx=-168.0, δy=-60.0, δz=320.0)
