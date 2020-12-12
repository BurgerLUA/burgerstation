var/global/list/area/transit/transit_areas = list()

/area/transit
	name = "transit"
	icon_state = "shuttle"
	flags_area = FLAGS_AREA_NO_DAMAGE | FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS | FLAGS_AREA_NO_TELEPORT
	var/turf/transit_turf = /turf/simulated/floor/plating
	safe_storage = TRUE
	trackable = TRUE
	allow_ghosts = FALSE

/area/transit/New(var/desired_loc)
	transit_areas[type] = src
	return ..()

/area/transit/cargo/ship
	name = "cargo shuttle"
	area_identifier = "Burgerstation"

/area/transit/cargo/bluespace
	name = "cargo shuttle"
	transit_turf = /turf/bluespace

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/transit/cargo/centcomm
	name = "cargo shuttle"
	area_identifier = "Centcomm"

/area/transit/cargo_inbound/ship
	name = "cargo shuttle"
	area_identifier = "Burgerstation"


/area/transit/cargo_inbound/bluespace
	name = "cargo shuttle"

	cheese_type = /reagent/nutrition/cheese/bluespace

/area/transit/cargo_inbound/centcomm
	name = "cargo shuttle"
	area_identifier = "Centcomm"


