/area/shuttle
	name = "shuttle area"
	icon_state = "shuttle"
	flags_area = FLAGS_AREA_NO_CONSTRUCTION | FLAGS_AREA_NO_EVENTS
	safe_storage = TRUE
	trackable = TRUE
	allow_ghost = FALSE
	map_color = COLOR_PINK
	interior = TRUE

	area_identifier = "Burgerstation"

	var/area/shuttle_area = /area/ //REQUIRED

	var/area/shuttle_turf = /turf/ //REQUIRED

/area/shuttle/debug
	name = "debug shuttle"
	shuttle_area = /area/burgerstation/hanger
	shuttle_turf = /turf/simulated/floor/plating