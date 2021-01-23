/turf/simulated/floor/cult
	name = "cult floor"
	icon = 'icons/turf/floor/cult.dmi'
	desc = "An arcane floor"
	desc_extended = "The patterns on these types of floor can make one mesmorized, but the effect is often ruined due to blood cult antics"
	icon_state = "floor1"

	footstep = /footstep/tile

	destruction_turf = /turf/simulated/floor/basalt/

/turf/simulated/floor/cult/New(var/desired_loc)

	icon_state = "floor[rand(1,4)]"

	if(prob(5))
		new/obj/effect/cult_decor/floor(src)

	..()

/turf/simulated/floor/cult/darker
	color = "#AAAAAA"

