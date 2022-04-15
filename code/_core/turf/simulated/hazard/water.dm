/turf/simulated/hazard/water
	name = "water"
	icon = 'icons/turf/floor/water.dmi'
	icon_state = "riverwater_static"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	footstep = /footstep/water
	fishing_rewards = /loot/fishing/river

	plane = PLANE_MOB
	layer = LAYER_MOB_WATER

	desired_light_frequency = 4
	desired_light_power = 0.5
	desired_light_range = 8
	desired_light_color = "#158996"

	water_reagent = /reagent/nutrition/water
	reagents = /reagent_container/turf/

	map_color = COLOR_BLUE

	blend_mode = BLEND_MULTIPLY


/turf/simulated/hazard/water/Exited(atom/movable/O, atom/newloc)

	. = ..()

	if(O.density && O.layer < LAYER_MOB_WATER && src.layer != newloc.layer)
		for(var/i=1,i<=5,i++)
			FILTER_REMOVE(O,"water[i]")

/turf/simulated/hazard/water/Entered(atom/movable/O, atom/oldloc)

	. = ..()

	if(O.density && O.layer < LAYER_MOB_WATER && src.layer != oldloc.layer)
		for(var/i=1,i<=5,i++)
			FILTER_ADD(O,"water[i]",type="wave",x=rand(40,50),y=rand(40,50),size=rand(2,4),offset=RAND_PRECISE(0,1))
			var/num = length(O.filters)
			var/f = O.filters[num]
			animate(f,offset=f:offset,time=0,loop=-1,flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1,time=rand(10,10))


/turf/simulated/hazard/water/Exit(atom/movable/O,atom/oldloc)

	if(O.layer <= LAYER_MOB_SWIMMING && src.layer != oldloc.layer && !O.grabbing_hand) //Keep fish and objects in the water, unless its being grabbed.
		return FALSE

	. = ..()

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
