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

# https://epsg.org/transformation_1241/NAD27-to-NAD83-1.html
@hgridshift NAD27 NAD83

# https://epsg.org/transformation_9239/NAD27-to-NAD83-CSRS-v2-1.html
@hgridshift NAD27 NAD83CSRS{2}

# https://epsg.org/transformation_9107/NAD27-to-NAD83-CSRS-v3-5.html
@hgridshift NAD27 NAD83CSRS{3}

# https://epsg.org/transformation_5529/SAD69-96-to-SIRGAS-2000-1.html
@hgridshift SAD96 SIRGAS2000
