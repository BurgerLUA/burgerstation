/*
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
*/

/turf/unsimulated/generation/lava
	name = "lava generation"
	icon_state = "lava"

/turf/unsimulated/generation/lava/path
	icon_state = "lava_path"
	density = FALSE

/turf/unsimulated/generation/lava/generate(var/size = WORLD_SIZE)

	if(density && (x <= VIEW_RANGE || x >= size - VIEW_RANGE || y <= VIEW_RANGE || y >= size - VIEW_RANGE)) //Handle edges.
		if(x<=2 || y<=2 || x>=size-2 || y>=size-2)
			new /turf/simulated/wall/rock/basalt(src)
		else if(x == VIEW_RANGE || x == size - VIEW_RANGE || y == VIEW_RANGE || y == size - VIEW_RANGE)
			new /turf/simulated/liquid/lava(src)
			new /obj/marker/generation/turf/lava/floor_only(src)
		else
			new /turf/simulated/wall/rock/basalt(src)
			new /obj/marker/generation/turf/basalt_wall(src)

		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	if(is_different)
		if(density && is_next_to_null_areas && is_next_to_dense_turfs && is_next_to_organic_turfs)
			if(prob(2))
				new /obj/marker/generation/turf/basalt_wall(src)
			else if(prob(2))
				new /obj/marker/generation/turf/lava(src)
			new /turf/simulated/wall/rock/basalt(src)
		else
			if(prob(1))
				new /obj/marker/generation/turf/basalt(src)
			if(prob(1))
				new /obj/marker/generation/plant/glowcap(src)
			new /turf/simulated/floor/basalt(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			if(density)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/magma(src)
				new /turf/simulated/liquid/lava(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/embershroom_mushroom(src)
				else if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			if(density)
				if(prob(1))
					new /obj/marker/generation/mob/watcher(src)
				else if(prob(0.25))
					new /obj/marker/generation/mob/slime/magma(src)
					if(prob(1))
						new /obj/marker/generation/plant/embershroom_mushroom(src)
				new /turf/simulated/liquid/lava(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/embershroom_mushroom(src)
				else if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_HIGH - 0.1)
			if(density)
				if(prob(1))
					new /obj/marker/generation/turf/lava/small(src)
					new /obj/marker/generation/mob/watcher(src)
					if(prob(1))
						new /obj/marker/generation/plant/embershroom_mushroom(src)
					new /turf/simulated/liquid/lava(src)
				else if(prob(1))
					if(prob(1))
						new /obj/marker/generation/plant/cactus_fruit(src)
					if(prob(1))
						new /obj/marker/generation/mob/goliath_ancient(src)
						if(prob(1))
							new /obj/marker/generation/plant/porcini_mushroom(src)
					else
						new /obj/marker/generation/mob/goliath(src)
						if(prob(1))
							new /obj/marker/generation/plant/porcini_mushroom(src)
					new /obj/marker/generation/turf/basalt(src)
				else if(prob(1))
					new /obj/marker/generation/turf/basalt_wall(src)
					new /turf/simulated/wall/rock/basalt(src)
				else if(prob(0.25))
					if(prob(1))
						new /obj/marker/generation/turf/ash_wall(src)
					else
						new /obj/marker/generation/mob/ash_walker(src)
						if(prob(1))
							new /obj/marker/generation/plant/polypore_mushroom(src)
						new /obj/marker/generation/turf/ash_floor(src)
					new /turf/simulated/floor/colored/ash/volcanic(src)
				else
					new /turf/simulated/floor/basalt(src)
			else
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGH - 0.1 to GENERATION_SEGMENT_HIGH)
			if(density)
				if(prob(1))
					new /obj/marker/generation/turf/ash_wall(src)
				new /turf/simulated/wall/ash/volcanic(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/polypore_mushroom(src)
				else if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				if(prob(1))
					new /obj/marker/generation/turf/ash_floor(src)
					new /obj/marker/generation/mob/ash_walker(src)
				new /turf/simulated/floor/colored/ash/volcanic(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			if(density)
				if(prob(1))
					if(prob(1))
						new /obj/marker/generation/plant/cactus_fruit(src)
					new /turf/simulated/floor/basalt(src)
					new /obj/marker/generation/mob/legion(src)
					new /obj/marker/generation/turf/basalt(src)
				else
					new /turf/simulated/wall/rock/basalt(src)
					new /obj/marker/generation/turf/basalt_wall(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				new /turf/simulated/wall/rock/basalt(src)
			else
				if(prob(1))
					new /obj/marker/generation/plant/glowcap(src)
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE

	if(src.loc.type == /area/) new /area/mission/lava(src)

	return ..()


/turf/unsimulated/generation/lava/pre_generate()

	var/x_seed = x / world.maxx
	var/y_seed = y / world.maxy

	. = ..()

	noise += text2num(rustg_noise_get_at_coordinates("[SSturf.seeds[z+10]]","[x_seed]","[y_seed]"))
	noise = MODULUS(noise,1)