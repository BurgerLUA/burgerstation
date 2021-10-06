/turf/simulated/hazard/water
	name = "water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_WALKING | FLAG_COLLISION_CRAWLING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water
	fishing_rewards = /loot/fishing/river

	density_north = TRUE
	density_east = TRUE
	density_south = TRUE
	density_west = TRUE

	plane = PLANE_FLOOR
	layer = 0

	desired_light_frequency = 4
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#158996"

	water_reagent = /reagent/nutrition/water
	reagents = /reagent_container/turf/

	map_color = COLOR_BLUE

/turf/simulated/hazard/water/jungle/Finalize()
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


/turf/simulated/hazard/water/sea
	name = "saltwater"
	fishing_rewards = /loot/fishing/sea

/turf/simulated/hazard/water/sea/Finalize()
	. = ..()
	update_sprite()

/turf/simulated/hazard/water/sea/update_overlays()

	. = ..()

	var/image/I1 = new/image(icon,"scroll_1")
	I1.appearance_flags = appearance_flags | RESET_COLOR
	I1.alpha = 225
	add_overlay(I1)

	var/image/I2 = new/image(icon,"scroll_2")
	I2.appearance_flags = appearance_flags | RESET_COLOR
	I2.alpha = 225
	add_overlay(I2)

	var/image/I3 = new/image(icon,"scroll_3")
	I3.appearance_flags = appearance_flags | RESET_COLOR
	I3.alpha = 225
	add_overlay(I3)
