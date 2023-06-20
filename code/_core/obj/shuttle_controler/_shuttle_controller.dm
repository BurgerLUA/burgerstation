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

/obj/shuttle_controller/PreDestroy()
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
	transit_marker_base.set_reserved(TRUE)

	transit_marker_bluespace = new(T2)
	transit_marker_bluespace.owning_shuttle = src
	transit_marker_bluespace.set_reserved(TRUE)

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
		CHECK_TICK(75,FPS_SERVER)

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
			CHECK_TICK(75,FPS_SERVER)
		src.stored_icon = I

	set_doors(TRUE,TRUE,TRUE) //Open and bolt all the doors!

/obj/shuttle_controller/proc/set_destination(var/mob/caller,var/obj/marker/shuttle_landing/desired_marker)

	if(!is_safe_to_land(caller,desired_marker))
		return FALSE

	src.transit_marker_destination = desired_marker

	return TRUE