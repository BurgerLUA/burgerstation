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


/turf/simulated/floor/Exited(var/atom/enterer,var/atom/old_loc)
	. = ..()
	if(is_living(enterer) && footstep_sounds && length(footstep_sounds))
		play_sound(pick(footstep_sounds),all_mobs_with_clients,vector(enterer.x,enterer.y,enterer.z),environment = area.sound_environment)