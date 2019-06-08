/turf/simulated/floor/
	name = "FLOOR"
	density_down = TRUE

	var/list/footstep_sounds = list(
		'sounds/effects/footsteps/floor1.ogg',
		'sounds/effects/footsteps/floor2.ogg',
		'sounds/effects/footsteps/floor3.ogg',
		'sounds/effects/footsteps/floor4.ogg',
		'sounds/effects/footsteps/floor5.ogg'
	)

	var/has_footprints = FALSE
	var/footprint_color = "#FFFFFF"
	var/footprint_alpha = 255


/turf/simulated/floor/is_safe_teleport()
	if(density)
		return FALSE

	return TRUE

/turf/simulated/floor/Entered(var/atom/movable/enterer,var/atom/old_loc)

	. = ..()

	if(is_living(enterer))
		var/mob/living/L = enterer
		var/area/A = src.loc
		spawn(TICKS_TO_DECISECONDS(enterer.get_movement_delay()*0.5))
			if(L.has_footsteps && footstep_sounds && length(footstep_sounds))
				var/footstep_sound = pick(footstep_sounds)
				if(L.footstep_override)
					footstep_sound = pick(L.footstep_override)

				play_sound(footstep_sound,all_mobs_with_clients - enterer,vector(enterer.x,enterer.y,enterer.z),environment = A.sound_environment,volume = FOOTSTEP_VOLUME, invisibility_check = enterer.invisibility)
				play_sound(footstep_sound,list(enterer),vector(enterer.x,enterer.y,enterer.z),environment = A.sound_environment, volume = FOOTSTEP_VOLUME/2)

			if(has_footprints && L.has_footprints)
				var/obj/effect/footprint/emboss/F = new(src,enterer.dir,TRUE,TRUE)
				F.color = footprint_color
				F.alpha = footprint_alpha
				F.Initialize()
				animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
				queue_delete(F,FOOTPRINT_FADE_TIME)

	return .

/turf/simulated/floor/Exited(var/atom/movable/exiter, var/atom/new_loc)

	. = ..()

	if(is_living(exiter))
		var/mob/living/L = exiter
		var/area/A = src.loc
		if(L.has_footsteps && footstep_sounds && length(footstep_sounds))
			var/footstep_sound = pick(footstep_sounds)
			if(L.footstep_override)
				footstep_sound = pick(L.footstep_override)
			play_sound(footstep_sound,all_mobs_with_clients - exiter,vector(exiter.x,exiter.y,exiter.z),environment = A.sound_environment,volume = FOOTSTEP_VOLUME, invisibility_check = exiter.invisibility)
			play_sound(footstep_sound,list(exiter),vector(exiter.x,exiter.y,exiter.z),environment = A.sound_environment, volume = FOOTSTEP_VOLUME/2)

		if(has_footprints && L.has_footprints)
			var/obj/effect/footprint/emboss/exit/F = new(src,exiter.dir,TRUE,TRUE)
			F.color = footprint_color
			F.alpha = footprint_alpha
			F.Initialize()
			animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
			queue_delete(F,FOOTPRINT_FADE_TIME)

	return .