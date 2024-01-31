

/turf/simulated/liquid/
	density = TRUE
	var/loot/fishing_rewards
	var/depth = 8 //The depth of the liquid.


/turf/simulated/liquid/

/turf/simulated/liquid/can_construct_on(mob/caller,obj/structure/structure_to_make)

	if(ispath(structure_to_make,/obj/structure/interactive/construction/))
		var/obj/structure/interactive/construction/C = locate() in contents
		if(C)
			caller.to_chat(span("warning","You can't build this here, \the [C.name] is in the way!"))
			return FALSE
		return TRUE

	. = ..()

/turf/simulated/liquid/Finalize()

	. = ..()

	if(alpha < 255)
		plane = PLANE_WATER
		mouse_opacity = 0
		vis_contents += SSturf.water_ground
	else
		plane = PLANE_FLOOR
		mouse_opacity = 1

/turf/simulated/liquid/Exit(atom/movable/O,atom/newloc)

	if(O.plane <= PLANE_MOVABLE_UNDERWATER && src.layer != newloc.layer && !O.grabbing_hand) //Keep fish and objects in the water, unless its being grabbed.
		return FALSE
	else if(is_living(O) && (O.collision_flags & FLAG_COLLISION_WATER) && newloc.type != src.type)
		var/mob/living/L = O
		if(L.climb_counter < 1 + depth*0.4)
			L.climb_counter++
			return FALSE
		L.climb_counter = 0

	. = ..()


/turf/simulated/liquid/Enter(atom/movable/O, atom/oldloc)

	if(is_living(O) && O.collision_flags & FLAG_COLLISION_WATER)
		var/mob/living/L = O
		if(!L.on_liquid)
			if(L.climb_counter < 2)
				L.climb_counter++
				return FALSE
		L.climb_counter = 0

	. = ..()


/turf/simulated/liquid/Entered(atom/movable/O,atom/OldLoc)

	if(is_living(O) && O.collision_flags & FLAG_COLLISION_WATER)
		var/mob/living/L = O
		L.on_liquid = depth
		L.handle_transform()

	. = ..()

/turf/simulated/liquid/Exited(atom/movable/O,atom/NewLoc)

	if(is_living(O) && O.collision_flags & FLAG_COLLISION_WATER)
		var/mob/living/L = O
		L.on_liquid = 0
		L.handle_transform()

	. = ..()