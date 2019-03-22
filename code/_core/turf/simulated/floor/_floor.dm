/turf/simulated/floor/
	name = "FLOOR"
	icon_state = "floor"
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

/turf/simulated/floor/Entered(var/atom/movable/enterer,var/atom/old_loc)

	. = ..()

	if(is_living(enterer))
		spawn(TICKS_TO_DECISECONDS(enterer.get_movement_delay()*0.5))
			if(footstep_sounds && length(footstep_sounds))
				var/footstep_sound = pick(footstep_sounds)
				play_sound(footstep_sound,all_mobs_with_clients - enterer,vector(enterer.x,enterer.y,enterer.z),environment = area.sound_environment,volume = FOOTSTEP_VOLUME, invisibility_check = enterer.invisibility)
				play_sound(footstep_sound,list(enterer),vector(enterer.x,enterer.y,enterer.z),environment = area.sound_environment, volume = FOOTSTEP_VOLUME/2)

			if(has_footprints)
				var/obj/effect/footprint/emboss/F = new(src,enterer.dir,TRUE,TRUE)
				F.color = footprint_color
				F.alpha = footprint_alpha
				F.Initialize()
				animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
				queue_delete(F,FOOTPRINT_FADE_TIME)

/turf/simulated/floor/Exited(var/atom/movable/exiter, var/atom/new_loc)

	. = ..()

	if(is_living(exiter))
		if(footstep_sounds && length(footstep_sounds))
			var/footstep_sound = pick(footstep_sounds)
			play_sound(footstep_sound,all_mobs_with_clients - exiter,vector(exiter.x,exiter.y,exiter.z),environment = area.sound_environment,volume = FOOTSTEP_VOLUME, invisibility_check = exiter.invisibility)
			play_sound(footstep_sound,list(exiter),vector(exiter.x,exiter.y,exiter.z),environment = area.sound_environment, volume = FOOTSTEP_VOLUME/2)

		if(has_footprints)
			var/obj/effect/footprint/emboss/exit/F = new(src,exiter.dir,TRUE,TRUE)
			F.color = footprint_color
			F.alpha = footprint_alpha
			F.Initialize()
			animate(F,alpha=0,time=FOOTPRINT_FADE_TIME,easing=QUAD_EASING)
			queue_delete(F,FOOTPRINT_FADE_TIME)