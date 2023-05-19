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

	var/obj/marker/shuttle_landing/transit_marker_base //The shuttle's base location. Created at new. Doesn't change past load.
	var/obj/marker/shuttle_landing/transit_marker_bluespace //The shuttle's bluespace location. Doesn't change past load.

	var/obj/marker/shuttle_landing/transit_marker_destination //The shuttle's desired location to transit to.

	var/default_transit_time = SHUTTLE_DEFAULT_TRANSIT_TIME //In seconds
	var/default_waiting_time = SHUTTLE_DEFAULT_WAITING_TIME //In seconds.

	anchored = 1

	var/status_id

	initialize_type = INITIALIZE_LATE

	var/mob/last_caller = null //The last caller who interacted with this shuttle's launch, if any.

	var/start_sound = 'sound/effects/shuttle/hyperspace_begin.ogg'
	var/progress_sound = 'sound/effects/shuttle/hyperspace_progress.ogg'
	var/end_sound = 'sound/effects/shuttle/hyperspace_end.ogg'

	var/enable_shuttle_throwing = TRUE

	var/time_restricted = FALSE

	var/loyalty_owner = "NanoTrasen"

	var/icon/stored_icon

/obj/shuttle_controller/Destroy()
	all_shuttle_controlers -= src
	return ..()

/obj/shuttle_controller/New(var/desired_loc)

	all_shuttle_controlers += src

	var/turf/T = get_turf(src) //Not needed but whatever.
	var/turf/T2 = locate(T.x,T.y,SSdmm_suite.file_to_z_level["maps/_core/bluespace.dmm"])

	if(!T2)
		log_error("ERROR: [src.get_debug_name()] could not find a valid bluespace turf.")
		qdel(src)

	transit_marker_base = new(T)
	transit_marker_base.owning_shuttle = src
	transit_marker_bluespace = new(T2)
	transit_marker_bluespace.owning_shuttle = src

	transit_marker_base.reserved = TRUE

	return ..()

/obj/shuttle_controller/Finalize()

	. = ..()

	var/min_x = INFINITY
	var/min_y = INFINITY
	var/max_x = 0
	var/max_y = 0

	var/area/A = get_area(src)

	var/list/found_turfs = list()
	var/failure = FALSE
	for(var/turf/simulated/T in A.contents)
		min_x = min(min_x,T.x)
		min_y = min(min_y,T.y)
		max_x = max(max_x,T.x)
		max_y = max(max_y,T.y)
		if(abs(min_x - max_x) > 32)
			failure = TRUE
			break
		if(abs(min_y - max_y) > 32)
			failure = TRUE
			break
		found_turfs += T

	if(failure)
		log_error("Error: [src.get_debug_name()] was placed in an area ([A.get_debug_name()]) larger than 32x32!")
	else
		var/icon/I = ICON_INVISIBLE
		for(var/k in found_turfs)
			var/turf/T = k
			var/local_x = T.x - src.x
			var/local_y = T.y - src.y
			var/desired_color = "#FFFFFF"
			if(T.density)
				desired_color = "#B7B7B7"
			else if(T.has_dense_atom)
				desired_color = "#D8D8D8"
			I.DrawBox(desired_color,local_x + 16,local_y + 16)
		src.stored_icon = I

	set_doors(TRUE,TRUE,TRUE) //Open and bolt all the doors!

/obj/shuttle_controller/proc/launch(var/mob/caller,var/desired_transit_time) //In deciseconds. This proc will always be called to bluespace.

	if(!set_doors(FALSE,TRUE,TRUE)) //Something blocking?
		return FALSE

	last_caller = caller
	state = SHUTTLE_STATE_LAUNCHING
	time = 0

	if(!desired_transit_time) desired_transit_time = default_transit_time
	transit_time = max(1,desired_transit_time)

	if(start_sound) //Play shuttle sound.
		play_sound(start_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
		if(last_caller)
			create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)

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
		if(time >= 6) //Needs to be a hardcoded time as this is based on sound.
			if(!transit(transit_marker_bluespace,accelerating=TRUE))
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
			if(!transit_marker_destination)
				transit_marker_destination = transit_marker_base
			state = SHUTTLE_STATE_LANDING
			signal_landing(transit_marker_destination)
			time = 0

	if(state == SHUTTLE_STATE_LANDING)
		display = "Land"
		if(time >= 2) //Needs to be hardcoded as this is based on sound.
			if(!transit(transit_marker_destination,accelerating=FALSE))
				return FALSE
			set_doors(TRUE,TRUE,TRUE) //Open all the doors!
			if(end_sound)
				play_sound(end_sound,src.loc,range_min=VIEW_RANGE,range_max=VIEW_RANGE*3)
				if(last_caller)
					create_alert(VIEW_RANGE*3,src.loc,last_caller,ALERT_LEVEL_CAUTION)
			state = SHUTTLE_STATE_LANDED
			time = 0

	if(status_id) set_status_display(status_id,display)

	if(display)
		var/area/A = get_area(src)
		for(var/obj/structure/interactive/status_display/local_display/LD in A.contents)
			LD.set_text(display)

	return TRUE


/obj/shuttle_controller/proc/transit(var/obj/marker/shuttle_landing/desired_marker,var/accelerating=FALSE)

	var/list/areas_to_upate = list()

	var/turf/starting_turf = get_turf(src)
	var/area/starting_area = starting_turf.loc
	areas_to_upate[starting_area] = TRUE

	if(!istype(starting_turf.loc,/area/shuttle)) //marker exists outside a shuttle area
		CRASH("SHUTTLE ERROR: [src.get_debug_name()] is not in a valid shuttle area!")
		return FALSE

	var/transit_throw_x = 0
	var/transit_throw_y = 0
	switch(src.dir)
		if(NORTH)
			transit_throw_y += accelerating ? -1 : 1
		if(EAST)
			transit_throw_x += accelerating ? -1 : 1
		if(SOUTH)
			transit_throw_y -= accelerating ? -1 : 1
		if(WEST)
			transit_throw_x -= accelerating ? -1 : 1

	var/list/atom/movable/objects_to_throw = list()

	var/list/valid_turfs = list()

	for(var/turf/simulated/T in starting_area) //This is needed or else thing will be buggy.
		valid_turfs += T

	var/original_src_x = src.x
	var/original_src_y = src.y

	for(var/j in valid_turfs) //First pass: Stun everything.
		var/turf/T = j
		for(var/k in T.contents)
			var/atom/movable/M = k
			M.next_move = max(M.next_move,SECONDS_TO_TICKS(4))

	//First pass. Crush everything and add new turfs.
	for(var/j in valid_turfs) //Valid turfs are all the turfs in the shuttle area.
		var/turf/T = j
		var/offset_x = T.x - original_src_x
		var/offset_y = T.y - original_src_y
		var/turf/T_to_replace = locate(desired_marker.x + offset_x, desired_marker.y + offset_y, desired_marker.z) //The destination turf!
		if(!T_to_replace)
			log_error("Shuttle Warning: Could not find a turf to replace for [src.get_debug_name()] at T: [T.x],[T.y],[T.z] | SRC: [original_src_x],[original_src_y],[T.z].")
			valid_turfs -= T
			continue

		if(!T_to_replace.stored_shuttle_items)
			T_to_replace.stored_shuttle_items = list() //Create the list it needs to store shuttle items.

		if(is_simulated(T_to_replace)) //Crush everything in the destination turf that's attached. First pass.
			var/turf/simulated/S = T_to_replace
			for(var/k in S.linked_attachments)
				var/obj/structure/O = k
				if(!O || O.qdeleting)
					continue
				O.on_crush()
				if(!O.qdeleting)
					log_error("Warning: [O.get_debug_name()] was a crushed attached object, but it's not deleting!")
				CHECK_TICK_SAFE(75,FPS_SERVER)

		for(var/k in T_to_replace.contents) //Crush everything in the destination turf. First pass.
			var/atom/movable/M = k
			if(!M.density)
				continue
			M.on_crush()

		for(var/k in T_to_replace.contents)
			var/atom/movable/M = k
			if(!src || src.qdeleting)
				break
			if(!M || M.qdeleting)
				continue
			if(!M.density || M.anchored >= 2)
				continue
			T_to_replace.stored_shuttle_items += M
			M.force_move(src) //Stored in the shuttle controller, for now.
			CHECK_TICK_SAFE(75,FPS_SERVER)

		var/turf/old_turf_type = T_to_replace.type
		var/area/old_area_type = T_to_replace.loc.type
		areas_to_upate[T.loc] = TRUE
		if(T.plane == PLANE_SHUTTLE) T_to_replace.change_turf(T.type,TRUE,TRUE) //Change to shuttle turf.
		T_to_replace.change_area(T.loc.type) //Change to shuttle area.
		T_to_replace.transit_turf = old_turf_type
		T_to_replace.transit_area = old_area_type
		areas_to_upate[T_to_replace.loc] = TRUE


	//Second pass. Move everything.
	for(var/j in valid_turfs) //Valid turfs are all the turfs in the shuttle area.
		var/turf/T = j
		var/offset_x = T.x - original_src_x
		var/offset_y = T.y - original_src_y
		var/turf/T_to_replace = locate(desired_marker.x + offset_x, desired_marker.y + offset_y, desired_marker.z) //The destination turf!
		if(!T_to_replace)
			log_error("Shuttle Warning: Could not find a turf to replace for [src.get_debug_name()] at T: [T.x],[T.y],[T.z] | SRC: [original_src_x],[original_src_y],[T.z].")
			continue

		//Move attached objects.
		if(is_simulated(T))
			var/turf/simulated/S = T
			for(var/k in S.linked_attachments)
				var/obj/structure/O = k
				var/offset_move_x = T_to_replace.x + (O.x - O.attached_to.x)
				var/offset_move_y = T_to_replace.y + (O.y - O.attached_to.y)
				var/turf/T_to_move_to = locate(offset_move_x,offset_move_y, T_to_replace.z) //The destination turf!
				if(!T_to_move_to || !is_simulated(T_to_replace))
					log_error("ERROR: [offset_move_x],[offset_move_y],[T_to_replace.z] was not a valid simulated turf to attach [O.get_debug_name()] to!")
					qdel(O)
					continue
				var/turf/simulated/S_to_replace = T_to_replace
				S.unattach(O)
				O.force_move(T_to_move_to)
				S_to_replace.attach(O)

		//Move contents.
		for(var/k in T.contents)
			var/atom/movable/M = k
			if(M.anchored >= 2)
				continue
			if(M.loc != T)
				continue
			M.force_move(T_to_replace)
			if(enable_shuttle_throwing)
				objects_to_throw += M

		//Move stored shuttle items.
		for(var/k in T.stored_shuttle_items)
			var/atom/movable/M = k
			if(is_item(M))
				var/obj/item/I = M
				I.drop_item(T)
			else
				M.force_move(T)
			T.stored_shuttle_items -= M

		//"Delete" old turf.
		T.change_area(T.transit_area) //From shuttle area to old turf that existed under.
		if(T.plane == PLANE_SHUTTLE)
			T.change_turf(T.transit_turf) //From shuttle turf to old turf that existed under.
		areas_to_upate[T.loc] = TRUE

	for(var/k in areas_to_upate)
		var/area/A = k
		A.generate_average()

	if(enable_shuttle_throwing)
		for(var/k in objects_to_throw)
			var/atom/movable/M = k
			if(M.anchored || M.collision_flags & FLAG_COLLISION_ETHEREAL)
				continue
			if(istype(M,/obj/structure/))
				continue
			if(is_living(M) && locate(/obj/structure/interactive/chair) in M.loc.contents)
				continue
			M.throw_self(M,vel_x=transit_throw_x*8,vel_y=transit_throw_y*8)

	var/obj/marker/shuttle_landing/SL = locate() in starting_turf.contents
	if(!SL)
		log_error("Shuttle error: Could not find a shuttle landing marker!")
	else
		SL.reserved = FALSE

	return TRUE



/obj/shuttle_controller/proc/signal_landing(var/obj/marker/shuttle)

	var/area/A = get_area(src)

	var/turf_limt = 32*32
	for(var/turf/T in A.contents)
		turf_limt--
		if(turf_limt < 0)
			log_error("Warning : [src.get_debug_name()] exceeded reasonable shuttle turf limit when landing.")
			break
		var/local_x = T.x - src.x
		var/local_y = T.y - src.y
		var/turf/T2 = locate(shuttle.x + local_x,shuttle.y + local_y,shuttle.z)
		if(T2)
			new/obj/effect/temp/shuttle_landing(T2)

	return TRUE

/obj/shuttle_controller/proc/set_destination(var/mob/caller,var/obj/marker/shuttle_landing/desired_marker)

	if(state != SHUTTLE_STATE_LANDED)
		caller?.to_chat(span("notice","The shuttle is already in transit!"))
		return FALSE

	if(!desired_marker)
		caller?.to_chat(span("warning","Error: Invalid shuttle destination!"))
		return FALSE

	if(desired_marker.reserved)
		caller?.to_chat(span("warning","Error: Shuttle destination already is reserved or occupied!"))
		return FALSE

	src.transit_marker_destination = desired_marker

	return TRUE

/obj/shuttle_controller/proc/try_launch(var/mob/caller,var/obj/marker/shuttle_landing/desired_marker)

	if(!SSgamemode?.active_gamemode?.allow_launch)
		caller?.to_chat(span("warning","Error: Shuttles are not ready to launch yet."))
		return FALSE

	if(state != SHUTTLE_STATE_LANDED)
		caller?.to_chat(span("warning","Error: Shuttle is currently [src.state]."))
		return FALSE

	if(desired_marker)
		if(!set_destination(caller,desired_marker))
			return FALSE
	else if(!src.transit_marker_destination)
		caller?.to_chat(span("warning","Error: No transit destination set!"))
		return FALSE

	src.time = 0
	src.transit_marker_destination.reserved = TRUE
	src.state = SHUTTLE_STATE_WAITING

	return TRUE