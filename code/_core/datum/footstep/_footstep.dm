/footstep/
	var/id = null

	var/list/footstep_sounds = list()

	var/has_footprints = FALSE
	var/footprint_color = "#FFFFFF"
	var/footprint_alpha = 255

/footstep/proc/on_step(var/turf/T, var/atom/movable/caller, var/left_foot = FALSE)

	if(!is_living(caller))
		return

	var/mob/living/L = caller
	var/area/A = T.loc

	if(L.dead && L.horizontal)
		return FALSE

	if(left_foot)
		if(has_footprints && L.has_footprints)
			var/obj/effect/footprint/emboss/exit/F = new(T,L.dir,TRUE,TRUE)
			F.color = footprint_color
			F.alpha = footprint_alpha
			F.Initialize()
			animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
			queue_delete(F,FOOTPRINT_FADE_TIME)
	else
		spawn(TICKS_TO_DECISECONDS(L.get_movement_delay()*0.5))
			if(footstep_sounds && length(footstep_sounds))
				var/footstep_sound = pick(footstep_sounds)
				if(L.footstep_override)
					footstep_sound = pick(L.footstep_override)
				var/footstep_volume = 50 * (L.move_mod-0.5)
				if(L.is_sneaking)
					footstep_volume *= 0.5

				var/alert = ALERT_LEVEL_NONE
				if(is_player(caller))
					alert = ALERT_LEVEL_NOISE

				play_sound(footstep_sound,get_mobs_in_range(L,3) - L,vector(L.x,L.y,L.z),environment = A.sound_environment,volume = footstep_volume, invisibility_check = L.invisibility, channel = SOUND_CHANNEL_FOOTSTEPS, alert = alert)
				play_sound(footstep_sound,list(L),vector(L.x,L.y,L.z),environment = A.sound_environment,volume = footstep_volume)

			if(has_footprints && L.has_footprints)
				var/obj/effect/footprint/emboss/F = new(T,L.dir,TRUE,TRUE)
				F.color = footprint_color
				F.alpha = footprint_alpha
				F.Initialize()
				animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
				queue_delete(F,FOOTPRINT_FADE_TIME)


	return TRUE