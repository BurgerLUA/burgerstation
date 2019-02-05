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


/turf/simulated/floor/on_enter(var/atom/A)
	. = ..()
	if(is_living(A) && footstep_sounds && length(footstep_sounds))
		play_sound(pick(footstep_sounds),all_mobs_with_clients,vector(A.x,A.y,A.z),environment = area.sound_environment)