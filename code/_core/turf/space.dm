/turf/bluespace
	name = "bluespace"
	icon_state = "bluespace"
	opacity = 1
	plane = PLANE_SPACE

	parallax_icon = 'icons/obj/effects/parallax_bluespace.dmi'

/turf/bluespace/New(var/desired_loc)
	. = ..()
	icon = null
	icon_state = null
	invisibility = 101

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
	icon_state = "preview"
	opacity = 0
	plane = PLANE_SPACE

/turf/space/New(var/desired_loc)
	. = ..()
	icon = null
	icon_state = null
	invisibility = 101

/turf/space/is_space()
	return TRUE

/turf/space/Entered(atom/movable/Obj, atom/OldLoc)

	if(ismob(Obj) && !istype(Obj,/mob/abstract/))
		var/mob/M = Obj
		if(M.finalized)
			var/obj/marker/failsafe/FS = locate() in world
			if(FS)
				M.force_move(FS.loc)
			else
				var/atom/movable/fallback = pick(cryo_spawnpoints)
				M.force_move(get_turf(fallback))

	return ..()

/turf/space/blocking
	name = "deep space"
	opacity = 1
