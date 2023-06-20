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
		CHECK_TICK(75,FPS_SERVER)

	return TRUE

/obj/shuttle_controller/proc/is_safe_to_land(var/mob/caller,var/obj/marker/shuttle_landing/desired_marker)

	if(!SSgamemode?.active_gamemode?.allow_launch)
		caller?.to_chat(span("warning","Error: Shuttles are not ready to launch yet."))
		return FALSE

	if(src.state != SHUTTLE_STATE_LANDED)
		caller?.to_chat(span("notice","The shuttle is already in transit!"))
		return FALSE

	if(!desired_marker)
		caller?.to_chat(span("warning","Error: Invalid shuttle destination!"))
		return FALSE

	if(desired_marker.owning_shuttle && desired_marker.owning_shuttle != src)
		caller?.to_chat(span("warning","Error: Shuttle destination is a special landing zone!"))
		return FALSE

	if(desired_marker.reserved_by_shuttle)
		caller?.to_chat(span("warning","Error: Shuttle destination already is reserved or occupied!"))
		return FALSE

	return TRUE