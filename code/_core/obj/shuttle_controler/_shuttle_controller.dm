var/global/list/all_shuttle_controlers = list()

/obj/shuttle_controller
	name = "shuttle controller"
	desc = "Controls what happens when the shuttle moves."
	icon = 'icons/obj/shuttle.dmi'
	icon_state = "shuttle"
	invisibility = 101

	var/state = SHUTTLE_STATE_LANDED
	var/time = 0
	var/transit_time = 0

	var/display

	var/transit_source
	var/transit_target

	var/obj/marker/shuttle/transit_start //path
	var/obj/marker/shuttle/transit_bluespace //path
	var/obj/marker/shuttle/transit_end //path

	var/default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME //In seconsd
	var/default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME //In seconds.

	anchored = TRUE

	var/status_id

	initialize_type = INITIALIZE_LATE

	var/mob/last_caller = null //The last caller who interacted with this shuttle's launch, if any.

	var/start_sound = 'sound/effects/shuttle/hyperspace_begin.ogg'
	var/progress_sound = 'sound/effects/shuttle/hyperspace_progress.ogg'
	var/end_sound = 'sound/effects/shuttle/hyperspace_end.ogg'

	var/enable_shuttle_throwing = TRUE

	var/time_restricted = FALSE

	var/area/associated_area

/obj/shuttle_controller/Destroy()
	all_shuttle_controlers -= src
	return ..()

/obj/shuttle_controller/New(var/desired_loc)
	all_shuttle_controlers += src
	return ..()

/obj/shuttle_controller/Initialize()

	var/obj/marker/shuttle/M1 = shuttle_markers[transit_start]
	var/obj/marker/shuttle/M2 = shuttle_markers[transit_bluespace]
	var/obj/marker/shuttle/M3 = shuttle_markers[transit_end]

	if(!M1)
		log_error("SHUTTLE ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit starting marker ([transit_start])!")

	if(!M2)
		log_error("SHUTTLE ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit bluespace marker ([transit_bluespace])!")

	if(!M3)
		log_error("SHUTTLE ERROR: Transit shuttle [get_debug_name()] doesn't have a valid transit ending marker ([transit_end])!")

	if(!M1 || !M2 || !M3)
		qdel(src)
		return FALSE

	. =..()

	set_doors(TRUE,TRUE,TRUE) //Open and bolt all the doors!

	associated_area = get_area(src)

/obj/shuttle_controller/proc/launch(var/mob/caller,var/desired_transit_time) //In deciseconds

	if(!set_doors(FALSE,TRUE,TRUE)) //Something blocking?
		return FALSE

	last_caller = caller
	state = SHUTTLE_STATE_LAUNCHING
	time = 0

	if(start_sound)
		play_sound(start_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		if(last_caller)
			create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)

	var/area/A = get_area(src)
	if(!desired_transit_time) desired_transit_time = default_transit_time
	transit_time = max(1,desired_transit_time)
	if(A.type == transit_start)
		transit_target = transit_end
		transit_source = transit_start
	else
		transit_target = transit_start
		transit_source = transit_end
	return TRUE

/obj/shuttle_controller/proc/set_doors(var/open = TRUE,var/lock = FALSE,var/force = FALSE)

	. = TRUE //TRUE if nothing went wrong. False if something went wrong.

	var/area/A = get_area(src)

	for(var/obj/structure/interactive/door/airlock/shuttle/S in A.contents)

		var/obj/structure/interactive/scanner/living/S1 = locate() in S.loc.contents
		if(S1 && !S1.trigger(null,src,-1,-1)) //Unsafe to close.
			. = FALSE
			break

		var/exposed_to_space = S.get_best_touching_space(FALSE)

		for(var/direction in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(S,direction)
			var/obj/structure/interactive/scanner/living/S2 = locate() in T.contents
			if(S2 && !S2.trigger(null,src,-1,-1))
				. = FALSE //Unsafe to close.
				break

			var/obj/structure/interactive/door/airlock/AL = locate() in T.contents
			if(!AL || istype(AL,/obj/structure/interactive/door/airlock/shuttle/))
				//No airlock? Whatever, keep going.
				continue

			if(open)
				AL.open(null,lock,force)
			else
				AL.close(null,lock,force)

		if(.)
			if(open && !exposed_to_space)
				S.open(null,lock,force)
			else
				S.close(null,lock,force)


/obj/shuttle_controller/proc/on_shuttle_think()

	if(state == SHUTTLE_STATE_WAITING)
		display = "Prep\n[get_clock_time(FLOOR((default_waiting_time - time), 1))]"
		if(time >= default_waiting_time)
			if(!launch())
				time -= 5

	if(state == SHUTTLE_STATE_LAUNCHING)
		display = "IGNT"
		if(time >= 6) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_bluespace))
				return FALSE
			if(progress_sound)
				play_sound(progress_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
				if(last_caller)
					create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_TRANSIT
			time = 0

	if(state == SHUTTLE_STATE_TRANSIT)
		display = "Flight\n[get_clock_time(FLOOR((transit_time - time), 1))]"
		if(time >= transit_time)
			state = SHUTTLE_STATE_LANDING
			//signal_landing(transit_areas[transit_target]) TODO
			time = 0

	if(state == SHUTTLE_STATE_LANDING)
		display = "Land"
		if(time >= 2) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_target))
				return FALSE
			set_doors(TRUE,TRUE,TRUE) //Open all the doors!
			if(end_sound)
				play_sound(end_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
				if(last_caller)
					create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_LANDED
			time = 0
			transit_source = null
			transit_target = null

	if(status_id) set_status_display(status_id,display)

	return TRUE


/obj/shuttle_controller/proc/transit(var/ending_marker_type,var/accelerating=FALSE)

	var/list/areas_to_upate = list()

	var/turf/starting_turf = get_turf(src)
	var/area/starting_area = starting_turf.loc
	areas_to_upate |= starting_area

	if(!istype(starting_turf.loc,/area/shuttle))
		CRASH("SHUTTLE ERROR: [src.get_debug_name()] is not in a valid shuttle area!")
		return FALSE

	var/obj/marker/shuttle/shuttle_marker = shuttle_markers[ending_marker_type] //Shuttle marker to transport to.

	if(!shuttle_marker)
		CRASH("SHUTTLE ERROR: [src.get_debug_name()] could not find a valid shuttle marker of id [ending_marker_type]!")
		return FALSE

	var/transit_throw_x = 0
	var/transit_throw_y = 0

	switch(src.dir)
		if(NORTH)
			transit_throw_y += accelerating ? 1 : -1
		if(EAST)
			transit_throw_x += accelerating ? 1 : -1
		if(SOUTH)
			transit_throw_y -= accelerating ? 1 : -1
		if(WEST)
			transit_throw_x -= accelerating ? 1 : -1

	var/list/atom/movable/objects_to_throw = list()

	var/list/valid_turfs = list()

	for(var/turf/simulated/T in starting_area) //This is needed or else thing will be buggy.
		if(T.plane != PLANE_SHUTTLE)
			continue
		valid_turfs += T

	var/original_x = src.x
	var/original_y = src.y

	for(var/j in valid_turfs)
		var/turf/T = j
		CHECK_TICK(75,FPS_SERVER)
		var/offset_x = T.x - original_x
		var/offset_y = T.y - original_y
		var/turf/T_to_replace = locate(shuttle_marker.x + offset_x, shuttle_marker.y + offset_y, shuttle_marker.z)
		if(!T_to_replace)
			log_error("Shuttle Warning: Could not find a turf to replace for [src.get_debug_name()] at [shuttle_marker.x + offset_x],[shuttle_marker.y + offset_y],[shuttle_marker.z].")
			continue

		for(var/k in T_to_replace.contents)
			var/atom/movable/M = k
			M.on_crush()

		if(!T_to_replace.stored_shuttle_items) T_to_replace.stored_shuttle_items = list() //Create the list it needs to store shuttle items.

		for(var/obj/item/I in T_to_replace.contents) //Second pass. Get everything that might've been crushed. The second pass is one here as some containers/mobs/ect may drop items.
			T_to_replace.stored_shuttle_items += I
			I.force_move(src) //Stored in the shuttle controller, for now.

		var/turf/old_turf_type = T.type
		var/area/old_area_type = T.loc.type
		areas_to_upate |= T.loc
		T_to_replace.change_turf(T.type,TRUE,TRUE) //From destination turf to shuttle turf.
		T_to_replace.change_area(T.loc.type) //From destination area to shuttle area.
		T_to_replace.transit_turf = old_turf_type
		T_to_replace.transit_area = old_area_type
		areas_to_upate |= T.loc

		//Okay, time to move everything.
		for(var/k in T.contents)
			var/atom/movable/M = k
			CHECK_TICK(75,FPS_SERVER)
			if(!M.allow_shuttle_move) //For things like light.
				continue
			if(M.loc != T)
				continue
			M.next_move = max(M.next_move,SECONDS_TO_TICKS(3))
			M.force_move(T_to_replace)
			if(enable_shuttle_throwing)
				objects_to_throw += M

		for(var/k in T.stored_shuttle_items)
			var/obj/item/I = k
			I.drop_item(T)
			T.stored_shuttle_items -= I

		var/area/shuttle/A = T.loc
		T.change_area(T.transit_area ? T.transit_area : A.shuttle_area) //From shuttle area to old turf that existed under.
		T.change_turf(T.transit_turf ? T.transit_turf : A.shuttle_turf,TRUE,TRUE) //From shuttle turf to old turf that existed under.
		areas_to_upate |= T.loc

	for(var/k in areas_to_upate)
		var/area/A = k
		A.generate_average()
		world.log << "Area: [A.type]."

	if(enable_shuttle_throwing)
		for(var/k in objects_to_throw)
			var/atom/movable/M = k
			CHECK_TICK(75,FPS_SERVER)
			if(M.anchored || M.collision_flags & FLAG_COLLISION_ETHEREAL)
				continue
			if(istype(M,/obj/structure/))
				continue
			if(is_living(M) && locate(/obj/structure/interactive/chair) in M.loc.contents)
				continue
			M.throw_self(M,null,null,null,transit_throw_x*8,transit_throw_y*8)

	return TRUE