/footstep/

	var/list/footstep_sounds = list()

	var/has_footprints = FALSE
	var/footprint_color = "#FFFFFF"
	var/footprint_alpha = 255

	var/variation_pitch = 0.1


/*
/footstep/proc/on_step(var/turf/T, var/atom/movable/caller, var/left_foot = FALSE)

	if(left_foot)
		if(has_footprints)
			var/obj/effect/footprint/emboss/exit/F = new(T,caller.dir,TRUE,TRUE)
			F.color = footprint_color
			F.alpha = footprint_alpha
			INITIALIZE(F)
			animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
			queue_delete(F,FOOTPRINT_FADE_TIME)
	else
		spawn(TICKS_TO_DECISECONDS(caller.get_movement_delay()*0.5))
			if(footstep_sounds && length(footstep_sounds))
				var/footstep_sound = pick(footstep_sounds)
				var/footstep_volume = 50 * (caller.move_mod-0.5)
				if(caller.is_sneaking)
					footstep_volume *= 0.5

				play(footstep_sound,all_mobs_with_clients - caller,T,volume = footstep_volume, sound_setting = SOUND_SETTING_FOOTSTEPS, pitch= 1 + RAND_PRECISE(-variation_pitch,variation_pitch))
				play(footstep_sound,caller,volume = footstep_volume, sound_setting = SOUND_SETTING_FOOTSTEPS, pitch= 1 + RAND_PRECISE(-variation_pitch,variation_pitch))

			if(has_footprints && caller.has_footprints)
				var/obj/effect/footprint/emboss/F = new(T,caller.dir,TRUE,TRUE)
				F.color = footprint_color
				F.alpha = footprint_alpha
				INITIALIZE(F)
				animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
				queue_delete(F,FOOTPRINT_FADE_TIME)


	return TRUE
*/