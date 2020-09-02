var/global/list/area/transit/transit_areas = list()

/area/transit
	name = "transit"
	icon_state = "shuttle"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS
	var/turf/transit_turf = /turf/simulated/floor/plating
	safe_storage = TRUE

/area/transit/New(var/desired_loc)
	transit_areas[type] = src
	return ..()

/area/transit/cargo/ship
	name = "cargo shuttle"

/area/transit/cargo/bluespace
	name = "cargo shuttle"
	transit_turf = /turf/unsimulated/bluespace

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/transit/cargo/centcomm
	name = "cargo shuttle"









/area/transit/cargo_inbound/ship
	name = "cargo shuttle"

/area/transit/cargo_inbound/bluespace
	name = "cargo shuttle"

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/transit/cargo_inbound/centcomm
	name = "cargo shuttle"

