/turf/simulated/wall/cult
	name = "cult wall"
	desc = "Spooky"
	desc_extended = "A wall made of a stange runic metal, simply looking at it makes you nervous."
	icon = 'icons/turf/wall/cult.dmi'
	icon_state = "wall"
	corner_category = "cult_wall"
	corner_icons = TRUE

	destruction_turf = /turf/simulated/floor/basalt

	map_color = "#600000"

	health_base = 1500

/turf/simulated/wall/cult/New()
	..()
	if(prob(5))
		new/obj/effect/cult_decor/wall(src)