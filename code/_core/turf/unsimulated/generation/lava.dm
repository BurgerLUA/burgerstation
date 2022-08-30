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

	if(density && (x <= VIEW_RANGE*2 || x >= size - VIEW_RANGE*2 || y <= VIEW_RANGE*2 || y >= size - VIEW_RANGE*2)) //Handle edges.
		new /turf/simulated/wall/rock/basalt(src)
		if(prob(2))
			new /obj/marker/generation/basalt_wall(src)
		else if(prob(0.5))
			new /obj/marker/generation/lava(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	if(density && is_different)
		if(is_next_to_dense_turf)
			new /turf/simulated/wall/rock/basalt(src)
			if(prob(2))
				new /obj/marker/generation/basalt_wall(src)
			else if(prob(2))
				new /obj/marker/generation/lava(src)
		else
			new /turf/simulated/floor/basalt(src)
			if(prob(1))
				new /obj/marker/generation/basalt(src)
		if(src.loc.type == /area/) new /area/mission/lava(src)
		return ..()

	switch(noise)
		if(-INFINITY to GENERATION_SEGMENT_LOWEST)
			if(density)
				new /turf/simulated/liquid/lava(src)
				if(prob(0.25))
					new /obj/marker/generation/mob/slime/magma(src)
			else
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOWEST to GENERATION_SEGMENT_LOW)
			if(density)
				new /turf/simulated/liquid/lava(src)
				if(prob(1))
					new /obj/marker/generation/mob/watcher(src)
				else if(prob(0.25))
					new /obj/marker/generation/mob/slime/magma(src)
			else
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_LOW to GENERATION_SEGMENT_MID)
			new /turf/simulated/floor/basalt(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/lava(src)
					new /obj/marker/generation/mob/watcher(src)
				else if(prob(2))
					new /obj/marker/generation/mob/ash_walker(src)
					new /obj/marker/generation/ash_floor(src)
				else if(prob(0.25))
					new /obj/marker/generation/mob/slime/basalt(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_MID to GENERATION_SEGMENT_HIGH)
			new /turf/simulated/floor/basalt(src)
			if(density)
				if(prob(1))
					new /obj/marker/generation/lava/small(src)
					new /obj/marker/generation/mob/watcher(src)
				if(prob(1))
					new /obj/marker/generation/basalt(src)
					if(prob(1))
						new /obj/marker/generation/mob/goliath_ancient(src)
					else
						new /obj/marker/generation/mob/goliath(src)
				else if(prob(1))
					new /obj/marker/generation/basalt_wall(src)
				else if(prob(0.25))
					if(prob(1))
						new /obj/marker/generation/ash_wall(src)
					else
						new /obj/marker/generation/mob/ash_walker(src)
					new /obj/marker/generation/ash_floor(src)
			else
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGH to GENERATION_SEGMENT_HIGHEST)
			if(density)
				if(prob(1))
					new /turf/simulated/floor/basalt(src)
					new /obj/marker/generation/mob/legion(src)
					new /obj/marker/generation/basalt(src)
				else
					new /turf/simulated/wall/rock/basalt(src)
					new /obj/marker/generation/basalt_wall(src)
			else
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE
		if(GENERATION_SEGMENT_HIGHEST to INFINITY)
			if(density)
				new /turf/simulated/wall/rock/basalt(src)
			else
				new /turf/simulated/floor/basalt(src)
				disallow_generation = TRUE

	if(!density && !disallow_generation && prob(3))
		new/obj/structure/interactive/basalt(src)

	if(src.loc.type == /area/) new /area/mission/lava(src)

	return ..()