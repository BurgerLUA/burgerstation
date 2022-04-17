var/global/obj/water_ground

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

	map_color = COLOR_BLUE

	alpha = 150

	depth = 8

/turf/simulated/liquid/water/jungle/Finalize()

	. = ..()

	if(prob(90))
		for(var/k in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,k)
			if(istype(T,/turf/simulated/floor))
				for(var/j=1,j<=rand(2,3),j++)
					var/obj/structure/scenery/reeds/R = new(src)
					R.pixel_x = rand(-8,8)
					R.pixel_y = rand(-8,8)
				break

/turf/simulated/liquid/water/sea
	name = "saltwater"
	fishing_rewards = /loot/fishing/sea