/turf/simulated/wall/proc/do_climb(mob/living/advanced/L,turf/actual_turf,turf/above_turf,turf/landing_turf)
	L.force_move(landing_turf)
	L.visible_message(
		span("notice","\The [L.name] climbs up from \the [above_turf.name]."),
		span("notice","You climb up \the [src.name], out of \the [above_turf.name].")
	)
	actual_turf.visible_message(
		span("notice","\The [L.name] climbs up \the [src.name].")
	)
	return TRUE


/turf/simulated/wall/proc/can_climb(mob/living/advanced/L,turf/actual_turf,turf/above_turf,turf/landing_turf)

	if(!actual_turf) //Huh.
		return FALSE
	if(!above_turf)
		L.to_chat(span("warning","There is nothing to climb to!"))
		return FALSE
	if(!landing_turf)
		L.to_chat(span("warning","There is nothing to climb to!"))
		return FALSE

	if(L.loc != actual_turf)
		return FALSE

	if(actual_turf.density_up) //Our turf.
		L.to_chat(span("warning","You can't climb above, \the [actual_turf.name] is in the way!"))
		return FALSE
	var/area/A = actual_turf.loc
	if(!A.allow_climbing)
		L.to_chat(span("warning","There is nothing to climb to!"))
		return FALSE
	if(above_turf.density_down)
		L.to_chat(span("warning","You can't climb above, \the [above_turf.name] above is in the way!"))
		return FALSE
	if(landing_turf.density)
		L.to_chat(span("warning","You can't climb above, \the [landing_turf.name] above is in the way!"))
		return FALSE

	return TRUE


/turf/simulated/wall/clicked_on_by_object(mob/caller,atom/object,location,control,params)


	if(is_advanced(caller))
		var/mob/living/advanced/L = caller
		if(L.intent == INTENT_GRAB)
			INTERACT_CHECK
			INTERACT_DELAY(10)
			var/turf/actual_turf = get_turf(caller)
			var/turf/above_turf = locate(actual_turf.x,actual_turf.y,actual_turf.z+1)
			var/turf/landing_turf = locate(x,y,z+1)
			if(!can_climb(L,actual_turf,above_turf,landing_turf))
				return TRUE
			PROGRESS_BAR(L,src,3 SECONDS,src::do_climb(),L,actual_turf,above_turf,landing_turf)
			PROGRESS_BAR_CONDITIONS(L,src,src::can_climb(),L,actual_turf,above_turf,landing_turf)
			return TRUE


	. = ..()
