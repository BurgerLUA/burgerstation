var/global/list/turf/simulated/floor/water_shores = list()

#define MAX_DEPTH (VIEW_RANGE + ZOOM_RANGE)

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
	if(!CONFIG("ENABLE_INSTALOAD",FALSE) && depth <= 0)
		for(var/k in DIRECTIONS_CARDINAL)
			if(!prob(80)) //Optimization
				continue
			var/turf/simulated/floor/T = get_step(src,k)
			if(!istype(T))
				continue
			water_shores |= T

/turf/simulated/liquid/water/Finalize()

	if(!CONFIG("ENABLE_INSTALOAD",FALSE))
		if(depth <= 0)
			depth = MAX_DEPTH
			for(var/k in water_shores)
				var/turf/simulated/floor/T = k
				depth = min(1 + get_dist(src,T),depth)
			var/noise = text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z]]","[x/world.maxx]","[y/world.maxy]"))
			if(NOISE_CURVES) noise = 0.5 + sin((noise+0.5)*NOISE_CURVES*180)*0.5

			depth = depth*0.5 + depth*noise*0.5
			map_color = blend_colors(map_color_min_depth,map_color_max_depth,depth/MAX_DEPTH)
			alpha = 128 + ((depth/MAX_DEPTH) * (254-128))
	else
		depth = 8
		alpha = 128 + ((depth/MAX_DEPTH) * (254-128))
		map_color = map_color_max_depth

	. = ..()

/turf/simulated/liquid/water/sea
	name = "sea water"
	fishing_rewards = /loot/fishing/sea

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
	if(depth <= 2 && prob(90))
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