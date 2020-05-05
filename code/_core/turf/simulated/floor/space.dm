/turf/simulated/floor/space
	name = "space"
	icon = 'icons/turf/space/space.dmi'
	icon_state = "1"
	var/generate = TRUE

	desired_light_power = 1
	desired_light_range = 4
	desired_light_color = "#CCD9E8"

	plane = PLANE_SPACE

/turf/simulated/floor/space/update_icon()
	icon_state = "[rand(0,25)]"

/turf/simulated/floor/space/transit
	icon_state = "speedspace_ew_1"

/turf/simulated/floor/space/transit/update_icon()
	icon_state = "speedspace_ew_[rand(1,15)]"
	return

/turf/simulated/floor/space/is_space()
	return TRUE

/turf/simulated/floor/space/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(is_player(O))
		var/mob/living/advanced/player/P = O
		P.to_chat(span("notice","How did you get here?"))
		var/obj/marker/failsafe/FS = locate() in world
		if(FS)
			O.force_move(FS.loc)
		else
			O.force_move(pick(cryo_spawnpoints).loc)
	return ..()