/obj/marker/generation
	name = "generation marker"
	icon = 'icons/obj/markers/generation.dmi'
	icon_state = "generation"

	var/atom/object_to_place

	var/turf/turf_whitelist

	var/turf/list/valid_turfs = list()
	var/turf/list/forbidden_turfs = list()

	var/grow_amount_min = 2
	var/grow_amount_max = 10

	var/objects_placed = 0
	var/objects_max = 50

	var/skip_chance = 25 //Higher values makes it look less circular.
	var/hole_chance = 5 //Higher values make it look more like swiss cheese.

	var/ignore_existing = FALSE

	pixel_x = -32
	pixel_y = -32

/obj/marker/generation/proc/grow(var/desired_grow)

	for(var/k in valid_turfs)
		var/turf/T = k
		valid_turfs -= T
		if(length(forbidden_turfs) && forbidden_turfs[T])
			continue
		forbidden_turfs[T] = TRUE //Already processed

		if(objects_placed > objects_max)
			return FALSE

		if(!prob(hole_chance) && !ispath(object_to_place,T) && !T.world_spawn && !(turf_whitelist && !istype(T,turf_whitelist)))
			new object_to_place(T)
			objects_placed++

		for(var/v in DIRECTIONS_CARDINAL)
			var/turf/T2 = get_step(T,v)
			if(!T2)
				continue
			if(prob(skip_chance))
				continue
			if(length(forbidden_turfs) && forbidden_turfs[T2])
				continue
			if(ispath(object_to_place,/turf/))
				if(T.loc != T2.loc)
					forbidden_turfs[T2] = TRUE //Already processed
					continue
			else
				if(!ignore_existing && T2.is_occupied())
					forbidden_turfs[T2] = TRUE //Already processed
					continue
			valid_turfs += T2

	return TRUE

/obj/marker/generation/proc/generate()

	var/desired_grow = rand(grow_amount_min,grow_amount_max)

	valid_turfs += get_turf(src)

	while(desired_grow > 0)
		desired_grow--
		if(!grow(desired_grow))
			break

	. = ..()

	return .


/obj/marker/generation/PostInitialize()
	. = ..()
	qdel(src)
	return .

/obj/marker/generation/grass
	object_to_place = /obj/structure/scenery/grass


/obj/marker/generation/lava
	object_to_place = /turf/simulated/hazard/lava
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 5

	color = COLOR_ORANGE

/obj/marker/generation/ice
	object_to_place = /turf/simulated/floor/ice
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 50
	skip_chance = 25
	hole_chance = 5

	color = COLOR_CYAN

/obj/marker/generation/water
	object_to_place = /turf/simulated/hazard/water
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 50
	skip_chance = 25
	hole_chance = 5

	color = COLOR_CYAN

/obj/marker/generation/snow
	object_to_place = /turf/simulated/floor/colored/snow
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

/obj/marker/generation/jungle_grass
	object_to_place = /turf/simulated/floor/colored/grass/jungle
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

/obj/marker/generation/jungle_dirt
	object_to_place = /turf/simulated/floor/colored/dirt/jungle
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/cave_dirt
	object_to_place = /turf/simulated/floor/cave_dirt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/snow_dirt
	object_to_place = /turf/simulated/floor/colored/dirt/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/basalt
	object_to_place = /turf/simulated/floor/basalt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK

/obj/marker/generation/rock_wall
	object_to_place = /turf/simulated/wall/rock
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 40
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK


/obj/marker/generation/rock_wall/small
	objects_max = 30
	skip_chance = 10


/obj/marker/generation/basalt_wall
	object_to_place = /turf/simulated/wall/rock/basalt
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK

/obj/marker/generation/jungle_wall
	object_to_place = /turf/simulated/wall/rock/moss
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK

/obj/marker/generation/snow_wall
	object_to_place = /turf/simulated/wall/rock/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY

/obj/marker/generation/snow_grass
	object_to_place = /obj/structure/scenery/snow_grass
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow


/obj/marker/generation/snow_tree
	object_to_place = /obj/structure/interactive/tree/pine
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 12
	skip_chance = 0
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow



/obj/marker/generation/jungle_tree
	object_to_place = /obj/structure/interactive/tree/jungle_large
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 2
	skip_chance = 10
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle


/obj/marker/generation/forest_tree
	object_to_place = /obj/structure/interactive/tree/evergreen
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 5
	skip_chance = 50
	hole_chance = 50

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass


/obj/marker/generation/flowers
	object_to_place = /obj/structure/scenery/flowers
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 4
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass


/obj/marker/generation/forest_grass
	object_to_place = /obj/structure/scenery/grass
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass





/obj/marker/generation/jungle_tree_small
	object_to_place = /obj/structure/interactive/tree/jungle_small
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 5
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle



/obj/marker/generation/jungle_high_grass
	object_to_place = /obj/structure/scenery/jungle_grass
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 10
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle


/obj/marker/generation/jungle_rock_grass
	object_to_place = /obj/structure/scenery/jungle_rock
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 10
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass



/obj/marker/generation/mob
	grow_amount_min = 20
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 90
	hole_chance = 0

	color = COLOR_RED

	turf_whitelist = /turf/simulated/floor/

	ignore_existing = TRUE


/obj/marker/generation/mob/arachnid
	object_to_place = /mob/living/simple/npc/arachnid
	objects_max = 1

/obj/marker/generation/mob/venus_human_trap
	object_to_place = /mob/living/simple/npc/venus_human_trap
	objects_max = 1
	turf_whitelist = /turf/simulated/floor/grass/jungle


/obj/marker/generation/mob/watcher
	object_to_place = /mob/living/simple/npc/watcher
	objects_max = 1

/obj/marker/generation/mob/goliath
	object_to_place = /mob/living/simple/npc/goliath
	objects_max = 1

/obj/marker/generation/mob/goliath_ancient
	object_to_place = /mob/living/simple/npc/goliath/ancient
	objects_max = 1

/obj/marker/generation/mob/black_bear
	object_to_place = /mob/living/simple/npc/bear/black
	objects_max = 1

/obj/marker/generation/mob/snow_bear
	object_to_place = /mob/living/simple/npc/bear/snow
	objects_max = 1

/obj/marker/generation/mob/chicken
	object_to_place = /mob/living/simple/npc/passive/chicken
	objects_max = 3

/obj/marker/generation/mob/cow
	object_to_place = /mob/living/simple/npc/passive/cow
	objects_max = 2

/obj/marker/generation/mob/cave_spider
	object_to_place = /mob/living/simple/npc/spider
	objects_max = 3
