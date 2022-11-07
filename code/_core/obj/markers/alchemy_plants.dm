/obj/marker/alchemy_plant/
	var/to_spawn = null
	var/allowed_turfs = list()
/obj/marker/alchemy_plant/New(var/desired_loc)
	new to_spawn(desired_loc)

/obj/marker/alchemy_plant/forest_nut
	to_spawn = /obj/structure/interactive/alchemy_plant/forest_nut
	allowed_turfs = list(/turf/simulated/floor/colored/grass)
/obj/marker/alchemy_plant/forest_berry
	to_spawn = /obj/structure/interactive/alchemy_plant/forest_berry
	allowed_turfs = list(/turf/simulated/floor/colored/grass)