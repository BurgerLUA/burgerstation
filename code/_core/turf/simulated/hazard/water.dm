var/global/list/turf/simulated/floor/water_shores = list()

#define MAX_DEPTH (VIEW_RANGE)

/turf/simulated/liquid/water
	name = "stagnant water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water
	fishing_rewards = null

	plane = PLANE_WATER
	layer = LAYER_MOB_WATER

	desired_light_frequency = 4
	desired_light_power = 0.25
	desired_light_range = 8
	desired_light_color = "#158996"

	var/map_color_max_depth = "#031A44"
	var/map_color_min_depth = "#3DAEE1"

	map_color = COLOR_BLUE

	depth = 0 // 0 Means generate depth.
	alpha = 255

	var/alpha_min = 75
	var/alpha_max = 150

	mouse_opacity = 1

	var/shore = FALSE

/turf/simulated/liquid/water/New(var/desired_loc)
	. = ..()
	if(depth == 0)
		depth = MAX_DEPTH

/turf/simulated/liquid/water/Initialize()
	. = ..()

	shore = FALSE
	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/simulated/floor/T = get_step(src,d)
		if(is_floor(T) && T.organic)
			shore = TRUE
			break
	if(shore)
		for(var/turf/simulated/liquid/water/W in oview(src,MAX_DEPTH))
			W.depth = min(W.depth,get_dist_real(W,src))

/turf/simulated/liquid/water/Finalize()

	alpha = alpha_min + ((depth/MAX_DEPTH) * (alpha_max-alpha_min))
	if(depth >= MAX_DEPTH)
		map_color = map_color_max_depth
	else if(depth <= 0)
		map_color = map_color_min_depth
	else
		map_color = blend_colors(map_color_min_depth,map_color_max_depth,depth/MAX_DEPTH)

	. = ..()

/turf/simulated/liquid/water/sea
	name = "sea water"
	fishing_rewards = /loot/fishing/sea

/turf/simulated/liquid/water/memorial
	name = "water"
	fishing_rewards = null
	depth = VIEW_RANGE * MAX_DEPTH

/turf/simulated/liquid/water/river
	name = "forest river water"
	fishing_rewards = /loot/fishing/river

/turf/simulated/liquid/water/river/ice
	name = "ice river water"
	fishing_rewards = /loot/fishing/river

/turf/simulated/liquid/water/river/jungle
	name = "jungle river water"
	fishing_rewards = /loot/fishing/river

/turf/simulated/liquid/water/river/jungle/Finalize()
	. = ..()
	if(depth <= 2 && ( (shore && prob(30)) || prob(10)) )
		for(var/j=1,j<=rand(2,3),j++)
			var/obj/structure/scenery/reeds/R = new(src)
			R.pixel_x = rand(-8,8)
			R.pixel_y = rand(-8,8)

/turf/simulated/liquid/water/cave
	name = "stagnant cave water"

/turf/simulated/liquid/water/pond
	name = "stagnant pond water"

/turf/simulated/liquid/water/desert
	name = "oasis water"