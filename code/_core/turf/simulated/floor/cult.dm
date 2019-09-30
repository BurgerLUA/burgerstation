/turf/simulated/floor/cult
	name = "cult floor"
	icon = 'icons/turf/floor/cult.dmi'
	icon_state = "floor1"

	desired_light_color = "#FFFFFF"

/turf/simulated/floor/cult/New(var/desired_loc)

	icon_state = "floor[rand(1,4)]"

	if(prob(5))
		new/obj/effect/cult_decor/floor(src)

	..()

/turf/simulated/floor/cult/darker
	color = "#AAAAAA"

