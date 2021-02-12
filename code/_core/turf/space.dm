/turf/bluespace
	name = "bluespace"
	icon_state = "bluespace"

/turf/bluespace/Entered(atom/movable/Obj, atom/OldLoc)

	if(!istype(Obj,/mob/abstract/))
		if(Obj.mouse_opacity) Obj.visible_message(span("danger","\The [Obj.name] flashes violently!"),span("danger","You flash violently!"))
		if(is_safe_to_delete(Obj))
			qdel(Obj)
		else if(length(rift_markers))
			Obj.force_move(get_turf(pick(rift_markers)))
			if(Obj.mouse_opacity) Obj.visible_message(span("danger","\The [Obj.name] appears out of nowhere!"),span("warning","You appear in some location..."))
		return TRUE

	return ..()


/turf/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	opacity = 0
	var/generate = TRUE
	plane = PLANE_SPACE

/turf/space/is_space()
	return TRUE

/turf/space/Entered(atom/movable/Obj, atom/OldLoc)

	if(ismob(Obj) && !istype(Obj,/mob/abstract/))
		var/mob/M = Obj
		if(M.initialized)
			var/obj/marker/failsafe/FS = locate() in world
			if(FS)
				M.force_move(FS.loc)
			else
				M.force_move(pick(cryo_spawnpoints).loc)

	return ..()

/turf/space/New(var/desired_loc)
	icon_state = "space"
	return ..()

/turf/space/blocking
	name = "deep space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "space"
	opacity = 1
	generate = FALSE
