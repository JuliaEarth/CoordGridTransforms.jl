# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

include("transforms/hgridshift.jl")
include("transforms/pointmotion.jl")

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
