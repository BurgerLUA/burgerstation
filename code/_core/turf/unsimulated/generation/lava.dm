var/global/list/possible_mushrooms = list(
	/obj/structure/interactive/plant/cactus_fruit = 6,
	/obj/structure/interactive/plant/polypore_mushroom = 1,
	/obj/structure/interactive/plant/porcini_mushroom = 1,
	/obj/structure/interactive/plant/inocybe_mushroom = 1,
	/obj/structure/interactive/plant/embershroom_mushroom = 1
)

var/global/list/possible_lavaland_fauna = list(
	/obj/marker/generation/mob/ash_walker = 5,
	/obj/marker/generation/mob/goliath = 10,
	/obj/marker/generation/mob/goliath_ancient = 1,
	/obj/marker/generation/mob/watcher = 5,
	/obj/marker/generation/mob/legion = 5
)
var/global/list/possible_lavaland_decor = list(
	/obj/structure/interactive/basalt = 5,
)

#define PLACE_MUSHROOM var/datum/D__LINE__ = pickweight(possible_mushrooms); new D__LINE__(src)
#define PLACE_LAVALAND_FAUNA var/datum/D__LINE__ = pickweight(possible_lavaland_fauna); new D__LINE__(src)
#define PLACE_LAVALAND_DECOR var/datum/D__LINE__ =pickweight(possible_lavaland_decor); new D__LINE__(src) //not used, I know!

/turf/unsimulated/generation/lava
	name = "lava generation"
	icon_state = "lava"

/turf/unsimulated/generation/lava/path
	icon_state = "lava_path"
	density = FALSE

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	if(!density)
		new /turf/simulated/floor/basalt(src)
		disallow_generation = TRUE
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	if(x <= VIEW_RANGE || x >= size - VIEW_RANGE || y <= VIEW_RANGE || y >= size - VIEW_RANGE) //Handle edges.
		new /turf/simulated/liquid/lava(src)
		if(prob(2))
			new /obj/marker/generation/lava(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	var/x_seed = x / size
	var/y_seed = y / size

	var/max_instances = 3
	var/noise = 0
	for(var/i=1,i<=max_instances,i++)
		noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+i]]","[x_seed]","[y_seed]"))
	noise *= 1/max_instances
	noise = 0.5 + sin((noise+0.5)*3*180)*0.5
	noise += (x/world.maxx + y/world.maxy)/2 - 0.5

	switch(noise) //Lower values means deeper.
		if(-INFINITY to 0.1)
			new /turf/simulated/liquid/lava(src)
			if(prob(5))
				new /obj/marker/generation/lava(src)
		if(0.1 to 0.4)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/ash_floor(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
			else if(prob(1))
				PLACE_MUSHROOM
			else if(prob(1))
				PLACE_LAVALAND_FAUNA

		if(0.4 to 0.5)
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/ash_floor(src)
				if(prob(1))
					new /obj/marker/generation/mob/ash_walker(src)
			else if(prob(1))
				PLACE_MUSHROOM
			else if(prob(1))
				PLACE_LAVALAND_FAUNA

		if(0.5 to 0.7)
			new /turf/simulated/floor/basalt(src)
			if(prob(3))
				PLACE_MUSHROOM
			else if(prob(1))
				PLACE_LAVALAND_FAUNA
			else if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
			else if(prob(1))
				new /obj/marker/generation/ash_wall(src)

		if(0.7 to 0.8)
			new /turf/simulated/floor/basalt(src)
			if(prob(3))
				PLACE_MUSHROOM
			else if(prob(1))
				PLACE_LAVALAND_FAUNA
			else if(prob(1))
				new /obj/marker/generation/lava(src)
			else if(prob(1))
				new /obj/marker/generation/basalt_wall(src)
			else if(prob(1))
				new /obj/marker/generation/ash_wall(src)

		if(0.8 to INFINITY)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(1))
				new /obj/marker/generation/mob/goliath(src)
			else if(prob(1))
				PLACE_MUSHROOM
			else if(prob(1))
				new /obj/marker/generation/ash_wall(src)
			else if(prob(0.1))
				new /obj/marker/generation/basalt(src)

	if(src.loc.type == /area/) new /area/mission/lava(src)

	return ..()