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
/obj/marker/alchemy_plant/snow_daisy
	to_spawn = /obj/structure/interactive/alchemy_plant/snow_daisy
	allowed_turfs = list(/turf/simulated/floor/colored/snow)
/obj/marker/alchemy_plant/space_cotton
	to_spawn = /obj/structure/interactive/alchemy_plant/space_cotton
	allowed_turfs = list(/turf/simulated/floor/colored/grass,/turf/simulated/floor/colored/snow,/turf/simulated/floor/colored/grass/jungle)
/obj/marker/alchemy_plant/devil_shroom
	to_spawn = /obj/structure/interactive/alchemy_plant/devil_shroom
	allowed_turfs = list(/turf/simulated/floor/basalt/)