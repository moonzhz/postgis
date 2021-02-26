# **********************************************************************
# *
# * PostGIS - Spatial Types for PostgreSQL
# * http://postgis.net
# *
# * Copyright (C) 2011-2020 Sandro Santilli <strk@kbt.io>
# * Copyright (C) 2009-2011 Paul Ramsey <pramsey@cleverelephant.ca>
# * Copyright (C) 2008-2009 Mark Cave-Ayland
# *
# * This is free software; you can redistribute and/or modify it under
# * the terms of the GNU General Public Licence. See the COPYING file.
# *
# **********************************************************************

POSTGIS_PGSQL_VERSION=130
POSTGIS_GEOS_VERSION=39
HAVE_JSON=yes
HAVE_SPGIST=yes
INTERRUPTTESTS=no

current_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TESTS += \
	$(topsrcdir)/regress/core/affine \
	$(topsrcdir)/regress/core/bestsrid \
	$(topsrcdir)/regress/core/binary \
	$(topsrcdir)/regress/core/boundary \
	$(topsrcdir)/regress/core/chaikin \
	$(topsrcdir)/regress/core/filterm \
	$(topsrcdir)/regress/core/cluster \
	$(topsrcdir)/regress/core/concave_hull\
	$(topsrcdir)/regress/core/ctors \
	$(topsrcdir)/regress/core/curvetoline \
	$(topsrcdir)/regress/core/dump \
	$(topsrcdir)/regress/core/dumppoints \
	$(topsrcdir)/regress/core/empty \
	$(topsrcdir)/regress/core/estimatedextent \
	$(topsrcdir)/regress/core/forcecurve \
	$(topsrcdir)/regress/core/geography \
	$(topsrcdir)/regress/core/geometric_median \
	$(topsrcdir)/regress/core/hausdorff \
	$(topsrcdir)/regress/core/in_geohash \
	$(topsrcdir)/regress/core/in_gml \
	$(topsrcdir)/regress/core/in_kml \
	$(topsrcdir)/regress/core/in_encodedpolyline \
	$(topsrcdir)/regress/core/iscollection \
	$(topsrcdir)/regress/core/legacy \
	$(topsrcdir)/regress/core/long_xact \
	$(topsrcdir)/regress/core/lwgeom_regress \
	$(topsrcdir)/regress/core/measures \
	$(topsrcdir)/regress/core/minimum_bounding_circle \
	$(topsrcdir)/regress/core/normalize \
	$(topsrcdir)/regress/core/operators \
	$(topsrcdir)/regress/core/orientation \
	$(topsrcdir)/regress/core/out_geometry \
	$(topsrcdir)/regress/core/out_geography \
	$(topsrcdir)/regress/core/polygonize \
	$(topsrcdir)/regress/core/polyhedralsurface \
	$(topsrcdir)/regress/core/postgis_type_name \
	$(topsrcdir)/regress/core/quantize_coordinates \
	$(topsrcdir)/regress/core/regress \
	$(topsrcdir)/regress/core/regress_bdpoly \
	$(topsrcdir)/regress/core/regress_buffer_params \
	$(topsrcdir)/regress/core/regress_gist_index_nd \
	$(topsrcdir)/regress/core/regress_index \
	$(topsrcdir)/regress/core/regress_index_nulls \
	$(topsrcdir)/regress/core/regress_management \
	$(topsrcdir)/regress/core/regress_selectivity \
	$(topsrcdir)/regress/core/regress_lrs \
	$(topsrcdir)/regress/core/regress_ogc \
	$(topsrcdir)/regress/core/regress_ogc_cover \
	$(topsrcdir)/regress/core/regress_ogc_prep \
	$(topsrcdir)/regress/core/regress_proj \
	$(topsrcdir)/regress/core/relate \
	$(topsrcdir)/regress/core/remove_repeated_points \
	$(topsrcdir)/regress/core/removepoint \
	$(topsrcdir)/regress/core/reverse \
	$(topsrcdir)/regress/core/setpoint \
	$(topsrcdir)/regress/core/simplify \
	$(topsrcdir)/regress/core/simplifyvw \
	$(topsrcdir)/regress/core/size \
	$(topsrcdir)/regress/core/snaptogrid \
	$(topsrcdir)/regress/core/split \
	$(topsrcdir)/regress/core/sql-mm-serialize \
	$(topsrcdir)/regress/core/sql-mm-circularstring \
	$(topsrcdir)/regress/core/sql-mm-compoundcurve \
	$(topsrcdir)/regress/core/sql-mm-curvepoly \
	$(topsrcdir)/regress/core/sql-mm-general \
	$(topsrcdir)/regress/core/sql-mm-multicurve \
	$(topsrcdir)/regress/core/sql-mm-multisurface \
	$(topsrcdir)/regress/core/swapordinates \
	$(topsrcdir)/regress/core/summary \
	$(topsrcdir)/regress/core/temporal \
	$(topsrcdir)/regress/core/temporal_knn \
	$(topsrcdir)/regress/core/tickets \
	$(topsrcdir)/regress/core/twkb \
	$(topsrcdir)/regress/core/typmod \
	$(topsrcdir)/regress/core/wkb \
	$(topsrcdir)/regress/core/wkt \
	$(topsrcdir)/regress/core/wmsservers \
	$(topsrcdir)/regress/core/offsetcurve \
	$(topsrcdir)/regress/core/relatematch \
	$(topsrcdir)/regress/core/isvaliddetail \
	$(topsrcdir)/regress/core/sharedpaths \
	$(topsrcdir)/regress/core/snap \
	$(topsrcdir)/regress/core/node \
	$(topsrcdir)/regress/core/unaryunion \
	$(topsrcdir)/regress/core/clean \
	$(topsrcdir)/regress/core/relate_bnr \
	$(topsrcdir)/regress/core/delaunaytriangles \
	$(topsrcdir)/regress/core/clipbybox2d \
	$(topsrcdir)/regress/core/subdivide \
	$(topsrcdir)/regress/core/voronoi \
	$(topsrcdir)/regress/core/regress_brin_index \
	$(topsrcdir)/regress/core/regress_brin_index_3d \
	$(topsrcdir)/regress/core/regress_brin_index_geography \
	$(topsrcdir)/regress/core/minimum_clearance \
	$(topsrcdir)/regress/core/oriented_envelope \
	$(topsrcdir)/regress/core/point_coordinates \
	$(topsrcdir)/regress/core/out_geojson

# Slow slow tests
TESTS_SLOW = \
	$(topsrcdir)/regress/core/concave_hull_hard \
	$(topsrcdir)/regress/core/knn_recheck

ifeq ($(shell expr "$(POSTGIS_PGSQL_VERSION)" ">=" 120),1)
	TESTS += \
		$(topsrcdir)/regress/core/computed_columns
endif

ifeq ($(shell expr "$(POSTGIS_GEOS_VERSION)" ">=" 37),1)
	# GEOS-3.7 adds:
	# ST_FrechetDistance
	TESTS += \
		$(topsrcdir)/regress/core/frechet
endif

ifeq ($(shell expr "$(POSTGIS_GEOS_VERSION)" ">=" 38),1)
	# GEOS-3.8 adds stable pointonsurface implementation
	TESTS += \
		$(topsrcdir)/regress/core/geos38
endif

ifeq ($(shell expr "$(POSTGIS_GEOS_VERSION)" ">=" 39),1)
	# GEOS-3.0 adds stable maximuminscribedcircle implementation
	TESTS += \
		$(topsrcdir)/regress/core/geos39 \
		$(topsrcdir)/regress/core/fixedoverlay
endif

ifeq ($(INTERRUPTTESTS),yes)
	# Allow CI servers to configure --with-interrupt-tests
	TESTS += \
		$(topsrcdir)/regress/core/interrupt \
		$(topsrcdir)/regress/core/interrupt_relate \
		$(topsrcdir)/regress/core/interrupt_buffer
endif

ifeq ($(HAVE_JSON),yes)
	# JSON-C adds:
	# ST_GeomFromGeoJSON()
	TESTS += \
		$(topsrcdir)/regress/core/in_geojson
endif

ifeq ($(HAVE_SPGIST),yes)
	TESTS += \
	$(topsrcdir)/regress/core/regress_spgist_index_2d \
	$(topsrcdir)/regress/core/regress_spgist_index_3d \
	$(topsrcdir)/regress/core/regress_spgist_index_nd
endif

ifeq (yes,yes)
	# protobuf-c adds:
	# ST_AsMVT, ST_AsGeobuf
	TESTS += \
		$(topsrcdir)/regress/core/mvt \
		$(topsrcdir)/regress/core/mvt_jsonb \
		$(topsrcdir)/regress/core/geobuf
endif
