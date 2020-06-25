/turf/simulated/floor/lava/
	name = "lava"
	icon = 'icons/turf/floor/lava2.dmi'
	desc = "Melting hot lava, dont fall in!"
	icon_state = "lava"

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT * 0.5
	desired_light_range = 6
	desired_light_color = "#FF8300"

	footstep = /footstep/lava

	plane = PLANE_WATER

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE
	density_up    = TRUE
	density_down  = TRUE
	allow_bullet_pass = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC