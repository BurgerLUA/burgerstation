/turf/simulated/wall/cult
	name = "cult wall"
	icon = 'icons/turf/wall/cult.dmi'
	icon_state = "wall"
	corner_category = "cult_wall"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/basalt

/turf/simulated/wall/cult/New()
	..()
	if(prob(5))
		new/obj/effect/cult_decor/wall(src.loc)