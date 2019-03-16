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


/turf/simulated/floor/Exited(var/atom/movable/exiter, var/atom/new_loc)
	. = ..()

	if(is_living(exiter))
		if(footstep_sounds && length(footstep_sounds))
			play_sound(pick(footstep_sounds),all_mobs_with_clients,vector(exiter.x,exiter.y,exiter.z),environment = area.sound_environment,volume = 25)

		if(has_footprints)
			var/obj/effect/footprint/emboss/exit/F = new(src,exiter.dir,TRUE,TRUE)
			F.color = footprint_color
			F.alpha = footprint_alpha
			F.Initialize()

/turf/simulated/floor/Entered(var/atom/movable/enterer,var/atom/old_loc)

	. = ..()

	if(is_living(enterer))
		spawn(TICKS_TO_DECISECONDS(enterer.get_movement_delay()*0.5))

			if(footstep_sounds && length(footstep_sounds))
				play_sound(pick(footstep_sounds),all_mobs_with_clients,vector(enterer.x,enterer.y,enterer.z),environment = area.sound_environment,volume = 25)

			if(has_footprints)
				var/obj/effect/footprint/emboss/F = new(src,enterer.dir,TRUE,TRUE)
				F.color = footprint_color
				F.alpha = footprint_alpha
				F.Initialize()