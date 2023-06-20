/turf/simulated/wall/
	name = "WALL"
	desc = "A wall"
	layer = LAYER_WALL
	plane = PLANE_WALL
	opacity = 1

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE
	density_up = TRUE
	density_down = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE

	map_color = "#000000"

	var/window_blend = FALSE

/turf/simulated/wall/is_occupied()
	return src

/turf/simulated/wall/proc/do_climb(var/mob/living/advanced/L,var/turf/actual_turf,var/turf/above_turf,var/turf/landing_turf)
	L.force_move(landing_turf)
	L.visible_message(
		span("notice","\The [L.name] climbs up from \the [above_turf.name]."),
		span("notice","You climb up \the [src.name], out of \the [above_turf.name].")
	)
	actual_turf.visible_message(
		span("notice","\The [L.name] climbs up \the [src.name].")
	)
	return TRUE


/turf/simulated/wall/proc/can_climb(var/mob/living/advanced/L,var/turf/actual_turf,var/turf/above_turf,var/turf/landing_turf)

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

/turf/simulated/wall/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

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
			PROGRESS_BAR(L,src,SECONDS_TO_DECISECONDS(3),src::do_climb(),L,actual_turf,above_turf,landing_turf)
			PROGRESS_BAR_CONDITIONS(L,src,src::can_climb(),L,actual_turf,above_turf,landing_turf)
			return TRUE

	. = ..()