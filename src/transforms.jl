# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

include("transforms/hgridshift.jl")

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

# https://epsg.org/transformation_7709/OSGB36-to-ETRS89-2.html
@hgridshift OSGB36 ETRF

# https://epsg.org/transformation_5529/SAD69-96-to-SIRGAS-2000-1.html
@hgridshift SAD96 SIRGAS2000
