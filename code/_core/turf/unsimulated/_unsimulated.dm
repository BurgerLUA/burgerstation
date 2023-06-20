/turf/unsimulated/
	opacity = 0

	dynamic_lighting = FALSE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = FALSE

	collision_flags = FLAG_COLLISION_UNSIMULATED

/turf/unsimulated/wall
	name = "WALL ERROR"

/turf/unsimulated/floor
	name = "FLOOR ERROR"

/turf/unsimulated/abyss
	name = "abyss"
	icon = 'icons/turf/space/abyss.dmi'
	icon_state = "abyss"
	opacity = 1
	density = TRUE

	desired_light_frequency = 2
	desired_light_power = 1
	desired_light_range = 8
	desired_light_color = "#FFFFFF"

/turf/unsimulated/void
	name = "abyss"
	icon = 'icons/turf/space/void.dmi'
	icon_state = "void"
	opacity = 1


/turf/proc/do_rock_gen()
	. = FALSE
	for(var/d in DIRECTIONS_ALL)
		var/turf/simulated/T = get_step(src,d)
		if(!T)
			continue
		if(T.type != /turf/unsimulated/dynamic_rock_gen)
			continue

		var/turf/desired_change_turf = /turf/simulated/wall/rock
		var/turf/above_turf = locate(x,y,z+1)
		if(above_turf)
			if(is_wall(above_turf))
				desired_change_turf = above_turf.type
			else
				var/area/A = above_turf.loc
				desired_change_turf = A.dynamic_rock_gen_turf
		T.change_turf(desired_change_turf)
		HOOK_ADD("on_destruction","\ref[T]_rock_gen_on_destruction",T,T,T::do_rock_gen())
		. = TRUE

/turf/unsimulated/dynamic_rock_gen
	name = "dynamic rock gen"
	density = 1
	opacity = 1