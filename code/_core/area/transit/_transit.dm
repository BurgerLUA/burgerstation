var/global/list/area/transit/transit_areas = list()

/area/transit
	name = "transit"
	icon_state = "shuttle"

/area/transit/New(var/desired_loc)
	transit_areas[id] = src
	return ..()



/area/transit/crew_shuttle/centcomm
	name = "spawn shuttle"
	id = "crew_shuttle_centcomm"

/area/transit/crew_shuttle/ship
	name = "spawn shuttle"
	id = "crew_shuttle_ship"

/area/transit/crew_shuttle/bluespace
	name = "spawn shuttle"
	id = "crew_shuttle_bluespace"


/area/transit/cargo/ship
	name = "cargo shuttle"
	id = "spawn_shuttle"

/area/transit/cargo/lz
	name = "spawn shuttle"
	id = "arrival_shuttle"

/proc/move_shuttle_by_id(var/starting_transit_id,var/bluespace_transit_id,var/ending_transit_id,var/transit_time=600)
	return move_shuttle(transit_areas[starting_transit_id],transit_areas[bluespace_transit_id],transit_areas[ending_transit_id],transit_time)

/proc/move_shuttle(var/area/transit/starting_transit,var/area/bluespace_transit,var/area/transit/ending_transit,var/transit_time = 600) //Time in deciseconds.

	var/obj/shuttle_controller/found_controller = locate() in starting_transit

	if(!found_controller)
		LOG_ERROR("Shuttle controller not found.")
		return FALSE

	if(transit_time < 50)
		transit_time = 50

	spawn()
		play_sound('sounds/effects/shuttle/hyperspace_begin.ogg',all_mobs_with_clients,vector(found_controller.x,found_controller.y,found_controller.z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		sleep(60)
		transit(starting_transit,bluespace_transit)
		sleep(1)
		play_sound('sounds/effects/shuttle/hyperspace_progress.ogg',all_mobs_with_clients,vector(found_controller.x,found_controller.y,found_controller.z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		sleep(transit_time - 18)
		signal_landing(ending_transit)
		sleep(18)
		transit(bluespace_transit,ending_transit)
		sleep(1)
		play_sound('sounds/effects/shuttle/hyperspace_end.ogg',all_mobs_with_clients,vector(found_controller.x,found_controller.y,found_controller.z),range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)

	return TRUE



/proc/transit_by_id(var/starting_transit_id,var/ending_transit_id)
	return transit(transit_areas[starting_transit_id],transit_areas[ending_transit_id])

/proc/signal_landing(var/area/transit/landing_area)
	for(var/turf/T in landing_area.contents)
		new/obj/effect/temp/shuttle_landing(T)

/proc/transit(var/area/transit/starting_transit,var/area/transit/ending_transit)

	var/obj/shuttle_controller/found_controller = locate() in starting_transit

	if(!found_controller)
		LOG_ERROR("Shuttle controller not found.")
		return FALSE

	var/starting_cord_x = starting_transit.x
	var/starting_cord_y = starting_transit.y

	var/ending_cord_x = ending_transit.x
	var/ending_cord_y = ending_transit.y

	for(var/turf/T in starting_transit)
		var/offset_x = T.x - starting_cord_x
		var/offset_y = T.y - starting_cord_y
		var/turf/replacing_turf = locate(ending_cord_x + offset_x, ending_cord_y + offset_y, 1)
		replacing_turf.change_turf(T.type)
		for(var/atom/movable/M in T.contents)
			if(!M.allow_shuttle_move)
				continue
			M.force_move(replacing_turf)
		T.change_turf(/turf/simulated/floor/plating)

	return TRUE

/client/verb/force_new_character_shuttle()
	if(!move_shuttle_by_id("crew_shuttle_centcomm","crew_shuttle_bluespace","crew_shuttle_ship",50))
		move_shuttle_by_id("crew_shuttle_ship","crew_shuttle_bluespace","crew_shuttle_centcomm",50)