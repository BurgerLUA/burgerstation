var/global/list/turf/simulated/floor/water_shores = list()

#define MAX_DEPTH (VIEW_RANGE + ZOOM_RANGE)

/turf/simulated/liquid/water
	name = "water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water
	fishing_rewards = /loot/fishing/river

	plane = PLANE_WATER
	layer = LAYER_MOB_WATER

	desired_light_frequency = 4
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#158996"

	water_reagent = /reagent/nutrition/water
	reagents = /reagent_container/turf/

	var/map_color_max_depth = "#031A44"
	var/map_color_min_depth = "#3DAEE1"

	map_color = COLOR_BLUE

	depth = 0 // 0 Means generate depth.
	alpha = 255

/turf/simulated/liquid/water/Initialize()
	. = ..()
	if(ENABLE_GENERATION)
		for(var/k in DIRECTIONS_ALL)
			var/turf/simulated/floor/T = get_step(src,k)
			if(!istype(T))
				continue
			water_shores |= T

/turf/simulated/liquid/water/Finalize()
	if(ENABLE_GENERATION)
		if(depth <= 0)
			depth = MAX_DEPTH
			for(var/k in water_shores)
				var/turf/simulated/floor/T = k
				depth = min(1 + get_dist(src,T),depth)
			map_color = blend_colors(map_color_min_depth,map_color_max_depth,depth/MAX_DEPTH)
			alpha = 128 + ((depth/MAX_DEPTH) * (254-128))
	else
		depth = 8
		alpha = 128 + ((depth/MAX_DEPTH) * (254-128))
		map_color = map_color_max_depth
	. = ..()

/turf/simulated/liquid/water/jungle/Finalize()
	. = ..()
	if(depth <= 2 && prob(90))
		for(var/j=1,j<=rand(2,3),j++)
			var/obj/structure/scenery/reeds/R = new(src)
			R.pixel_x = rand(-8,8)
			R.pixel_y = rand(-8,8)


/turf/simulated/liquid/water/sea
	name = "saltwater"
	fishing_rewards = /loot/fishing/sea