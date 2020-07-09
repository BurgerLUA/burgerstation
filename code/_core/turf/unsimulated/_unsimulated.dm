/turf/unsimulated/
	opacity = 0

	dynamic_lighting = FALSE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = FALSE


/turf/unsimulated/bluespace
	name = "bluespace"
	icon_state = "bluespace"

/turf/unsimulated/bluespace/Entered(atom/movable/Obj, atom/OldLoc)

	if(!istype(Obj,/mob/abstract/))
		Obj.visible_message(span("danger","\The [Obj.name] flashes violently!"))
		if(is_safe_to_delete(Obj) && (!SShorde || !length(SShorde.tracked_objectives) || !(Obj in SShorde.tracked_objectives)) )
			qdel(Obj)
		else
			Obj.force_move(get_turf(pick(rift_markers)))
			Obj.visible_message(span("danger","\The [Obj.name] appears out of nowhere!"))
		return TRUE

	return ..()

/turf/unsimulated/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	opacity = 0
	var/generate = TRUE
	plane = PLANE_SPACE

/turf/unsimulated/space/is_space()
	return TRUE

/turf/unsimulated/space/Entered(atom/movable/Obj, atom/OldLoc)

	if(ismob(Obj) && !istype(Obj,/mob/abstract/))
		var/mob/M = Obj
		if(M.initialized)
			var/obj/marker/failsafe/FS = locate() in world
			if(FS)
				M.force_move(FS.loc)
			else
				M.force_move(pick(cryo_spawnpoints).loc)

	return ..()

/turf/unsimulated/space/New(var/desired_loc)
	icon_state = "space"
	return ..()

/turf/unsimulated/space/blocking
	name = "deep space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "space"
	opacity = 1
	generate = FALSE

/turf/unsimulated/abyss
	name = "abyss"
	icon = 'icons/turf/space/abyss.dmi'
	icon_state = "abyss"
	opacity = 1

/turf/unsimulated/void
	name = "abyss"
	icon = 'icons/turf/space/void.dmi'
	icon_state = "void"
	opacity = 1