var/global/list/clown_planet_markers = list()

/obj/marker/clown_planet
	name = "clown planet marker"
	icon_state = "goal"

/obj/marker/clown_planet/New(var/desired_loc)
	clown_planet_markers += src
	. = ..()

/obj/marker/clown_planet/PreDestroy()
	clown_planet_markers -= src
	. = ..()