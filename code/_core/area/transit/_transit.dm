var/global/list/area/transit/transit_areas = list()

/area/transit
	name = "transit"
	icon_state = "shuttle"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION
	var/turf/transit_turf = /turf/simulated/floor/plating
	safe_storage = TRUE

/area/transit/New(var/desired_loc)
	transit_areas[id] = src
	return ..()

/area/transit/cargo/ship
	name = "cargo shuttle"
	id = "cargo_shuttle_station"

/area/transit/cargo/bluespace
	name = "cargo shuttle"
	id = "cargo_shuttle_bluespace"
	transit_turf = /turf/unsimulated

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/transit/cargo/planet
	name = "cargo shuttle"
	id = "cargo_shuttle_planet"

