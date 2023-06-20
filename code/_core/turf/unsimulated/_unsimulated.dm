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
		if(!T || T.type != /turf/unsimulated/dynamic_rock_gen)
			continue
		var/turf/desired_change_turf
		var/x_seed = x / world.maxx
		var/y_seed = y / world.maxy
		var/spawn_ore = FALSE
		var/noise_value = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z]]","[x_seed]","[y_seed]"))
		if(noise_value >= 0.3) //70% of the area is bedrock turf.
			desired_change_turf = /turf/simulated/wall/rock/indestructable
		else
			spawn_ore = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+1]]","[x_seed]","[y_seed]"))
			desired_change_turf = /turf/simulated/wall/rock
			var/turf/above_turf = locate(x,y,z+1)
			if(above_turf)
				if(is_wall(above_turf))
					desired_change_turf = above_turf.type
				else
					var/area/A = above_turf.loc
					desired_change_turf = A.dynamic_rock_gen_turf
		T.change_turf(desired_change_turf)
		if(spawn_ore <= 0.2 && is_wall(T) && T.density && T.health && T.health.organic) //20% of the non-bedrock turf contains ores.
			var/obj/structure/interactive/ore_deposit/wall/OD = new(T)
			OD.material_id = pickweight(ore_deposit_weights)
			OD.ore_amount = CEILING( (spawn_ore/0.2)*5 , 1)
			INITIALIZE(OD)
			FINALIZE(OD)
		HOOK_ADD("on_destruction","\ref[T]_rock_gen_on_destruction",T,T,T::do_rock_gen())
		. = TRUE

/turf/unsimulated/dynamic_rock_gen
	name = "dynamic rock gen"
	density = 1
	opacity = 1