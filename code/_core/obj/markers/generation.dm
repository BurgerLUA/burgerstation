/obj/marker/generation
	name = "generation marker"
	icon = 'icons/obj/markers/generation.dmi'
	icon_state = "generation"

	var/atom/object_to_place

	var/turf/turf_whitelist

	var/list/turf/valid_turfs = list()
	var/list/turf/forbidden_turfs = list()

	var/grow_amount_min = 2
	var/grow_amount_max = 10

	var/objects_placed = 0
	var/objects_max = 50

	var/skip_chance = 25 //Higher values makes it look less circular.
	var/hole_chance = 5 //Higher values make it look more like swiss cheese.

	var/ignore_existing = FALSE

	var/bypass_disallow_generation = FALSE

	pixel_x = -32
	pixel_y = -32

	var/priority = 0

	var/flags_generation = FLAG_GENERATION_NONE

/obj/marker/generation/New(var/desired_loc)
	. = ..()
	if(object_to_place)
		priority = initial(object_to_place.plane)*10000 + initial(object_to_place.layer)

/obj/marker/generation/proc/grow(var/desired_grow)

	for(var/k in valid_turfs)
		var/turf/T = k
		valid_turfs -= T
		if(length(forbidden_turfs) && forbidden_turfs[T])
			continue
		forbidden_turfs[T] = TRUE //Already processed

		if(objects_placed > objects_max)
			return FALSE

		if(!prob(hole_chance) && !ispath(object_to_place,T) && !T.world_spawn && (!turf_whitelist || istype(T,turf_whitelist)))
			new object_to_place(T)
			objects_placed++

		for(var/v in DIRECTIONS_CARDINAL)
			var/turf/T2 = get_step(T,v)
			if(!T2)
				continue
			if(T2.disallow_generation && !bypass_disallow_generation)
				continue
			var/area/A = T2.loc
			if(flags_generation && (A.flags_generation & flags_generation))
				continue
			if(length(forbidden_turfs) && forbidden_turfs[T2])
				continue
			if(prob(skip_chance))
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

/obj/marker/generation/proc/generate_marker()

	var/desired_grow = rand(grow_amount_min,grow_amount_max)

	valid_turfs += get_turf(src)

	while(desired_grow > 0)
		desired_grow--
		if(!grow(desired_grow))
			break

	return TRUE



/obj/marker/generation/PostInitialize()
	. = ..()
	qdel(src)

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

/obj/marker/generation/ash_floor
	object_to_place = /turf/simulated/floor/colored/ash/dark
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 10
	hole_chance = 0

	color = COLOR_GREY

/obj/marker/generation/ash_wall
	object_to_place = /turf/simulated/wall/ash/dark
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 10
	hole_chance = 0

	color = COLOR_GREY


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
	objects_max = 10
	skip_chance = 25
	hole_chance = 5

	color = COLOR_CYAN

/obj/marker/generation/water/jungle
	objects_max = 15
	object_to_place = /turf/simulated/hazard/water/jungle

/obj/marker/generation/sand
	object_to_place = /turf/simulated/floor/colored/sand/beach
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 30
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

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

/obj/marker/generation/forest_dirt
	object_to_place = /turf/simulated/floor/colored/dirt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 10
	skip_chance = 10
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/forest_soil
	object_to_place = /turf/simulated/floor/colored/dirt/soil
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 10
	skip_chance = 10
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

/obj/marker/generation/cave_dirt_colored
	object_to_place = /turf/simulated/floor/colored/dirt/cave
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
	object_to_place = /obj/structure/scenery/grass/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow

	bypass_disallow_generation = TRUE


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

/obj/marker/generation/jungle_light_flower
	object_to_place = /obj/structure/interactive/lighting/jungle/flower
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 2
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle

	bypass_disallow_generation = TRUE


/obj/marker/generation/jungle_light_stick
	object_to_place = /obj/structure/interactive/lighting/jungle/stick
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 4
	skip_chance = 10
	hole_chance = 20

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle

	bypass_disallow_generation = TRUE


/obj/marker/generation/jungle_light_lamp
	object_to_place = /obj/structure/interactive/lighting/jungle/lamp
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle

	bypass_disallow_generation = TRUE


/obj/marker/generation/jungle_light_mine
	object_to_place = /obj/structure/interactive/lighting/jungle/mine
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 2
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle

	bypass_disallow_generation = TRUE





/obj/marker/generation/forest_tree
	object_to_place = /obj/structure/interactive/tree/evergreen
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 10
	skip_chance = 50
	hole_chance = 50

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored


/obj/marker/generation/flowers
	object_to_place = /obj/structure/scenery/flowers
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 4
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

	bypass_disallow_generation = TRUE


/obj/marker/generation/forest_grass
	object_to_place = /obj/structure/scenery/grass/normal
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

	bypass_disallow_generation = TRUE


/obj/marker/generation/lavender
	object_to_place = /obj/structure/scenery/grass/lavender
	grow_amount_min = 4
	grow_amount_max = 6
	objects_max = 20
	skip_chance = 25
	hole_chance = 5

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass



/obj/marker/generation/bushes
	object_to_place = /obj/structure/scenery/bush/grass
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 5
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/bushes/fern
	object_to_place = /obj/structure/scenery/bush/fern

/obj/marker/generation/bushes/generic
	object_to_place = /obj/structure/scenery/bush/generic

/obj/marker/generation/bushes/grass
	object_to_place = /obj/structure/scenery/bush/grass

/obj/marker/generation/bushes/leafy
	object_to_place = /obj/structure/scenery/bush/leafy

/obj/marker/generation/bushes/pale
	object_to_place = /obj/structure/scenery/bush/pale

/obj/marker/generation/bushes/pointy
	object_to_place = /obj/structure/scenery/bush/pointy

/obj/marker/generation/bushes/snow
	object_to_place = /obj/structure/scenery/bush/snow

/obj/marker/generation/bushes/stalk
	object_to_place = /obj/structure/scenery/bush/stalk

/obj/marker/generation/bushes/stick
	object_to_place = /obj/structure/scenery/bush/stick

/obj/marker/generation/bushes/sun
	object_to_place = /obj/structure/scenery/bush/sun


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
	object_to_place = /obj/structure/scenery/grass/jungle
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 30
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle

	bypass_disallow_generation = TRUE

/obj/marker/generation/jungle_high_grass/small
	objects_max = 15
	skip_chance = 50
	hole_chance = 5


/obj/marker/generation/jungle_rock_grass
	object_to_place = /obj/structure/scenery/grass/jungle_rock
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 10
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

	bypass_disallow_generation = TRUE



/obj/marker/generation/mob
	grow_amount_min = 50
	grow_amount_max = 10
	objects_max = 3
	skip_chance = 50
	hole_chance = 0

	color = COLOR_RED

	turf_whitelist = /turf/simulated/floor/

	ignore_existing = TRUE

	flags_generation = FLAG_GENERATION_NO_MOB


/obj/marker/generation/mob/arachnid
	object_to_place = /mob/living/simple/arachnid
	objects_max = 1

/obj/marker/generation/mob/bat
	object_to_place = /mob/living/simple/bat
	objects_max = 3

/obj/marker/generation/mob/bee
	object_to_place = /mob/living/simple/bee
	objects_max = 2

/obj/marker/generation/mob/goat
	object_to_place = /mob/living/simple/passive/goat
	objects_max = 1

/obj/marker/generation/mob/mouse
	objects_max = 2

/obj/marker/generation/mob/mouse/brown
	object_to_place = /mob/living/simple/passive/mouse/brown

/obj/marker/generation/mob/mouse/white
	object_to_place = /mob/living/simple/passive/mouse/white

/obj/marker/generation/mob/mouse/grey
	object_to_place = /mob/living/simple/passive/mouse/grey



/obj/marker/generation/mob/venus_human_trap
	object_to_place = /mob/living/simple/venus_human_trap
	objects_max = 1
	turf_whitelist = /turf/simulated/floor/grass/jungle


/obj/marker/generation/mob/watcher
	object_to_place = /mob/living/simple/watcher
	objects_max = 1

/obj/marker/generation/mob/syndicate
	object_to_place = /mob/living/advanced/npc/syndicate
	objects_max = 1

/obj/marker/generation/mob/rev
	object_to_place = /mob/living/advanced/npc/rev
	objects_max = 1



/obj/marker/generation/mob/goliath
	object_to_place = /mob/living/simple/goliath
	objects_max = 1

/obj/marker/generation/mob/goliath_ancient
	object_to_place = /mob/living/simple/goliath/ancient
	objects_max = 1

/obj/marker/generation/mob/black_bear
	object_to_place = /mob/living/simple/bear/black
	objects_max = 1

/obj/marker/generation/mob/snow_bear
	object_to_place = /mob/living/simple/bear/snow
	objects_max = 1

/obj/marker/generation/mob/chicken
	object_to_place = /mob/living/simple/passive/chicken
	objects_max = 3

/obj/marker/generation/mob/cow
	object_to_place = /mob/living/simple/passive/cow
	objects_max = 2

/obj/marker/generation/mob/goblin
	object_to_place = /mob/living/advanced/npc/goblin
	objects_max = 3



/obj/marker/generation/mob/crab
	object_to_place = /mob/living/simple/crab
	objects_max = 3


/obj/marker/generation/mob/cave_spider
	object_to_place = /mob/living/simple/spider
	objects_max = 3

/obj/marker/generation/mob/legion
	object_to_place = /mob/living/simple/legionare
	objects_max = 1

/obj/marker/generation/mob/ash_walker
	object_to_place = /mob/living/advanced/npc/ashwalker/hunter
	objects_max = 1


/obj/marker/generation/plant
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 6
	skip_chance = 90
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/

/obj/marker/generation/plant/cabbage
	object_to_place = /obj/structure/interactive/plant/cabbage
	turf_whitelist = /turf/simulated/floor/colored/grass
	objects_max = 2

/obj/marker/generation/plant/chanterelle
	object_to_place = /obj/structure/interactive/plant/chanterelle
	turf_whitelist = /turf/simulated/floor/colored
	objects_max = 3

/obj/marker/generation/plant/destroying_angel
	object_to_place = /obj/structure/interactive/plant/destroying_angel
	turf_whitelist = /turf/simulated/floor/colored/dirt
	objects_max = 2

/obj/marker/generation/plant/fly_amanita
	object_to_place = /obj/structure/interactive/plant/fly_amanita
	turf_whitelist = /turf/simulated/floor/colored
	objects_max = 2

/obj/marker/generation/plant/glowshroom
	object_to_place = /obj/structure/interactive/plant/glowshroom
	turf_whitelist = /turf/simulated/floor
	objects_max = 2

/obj/marker/generation/plant/liberty_cap
	object_to_place = /obj/structure/interactive/plant/liberty_cap
	turf_whitelist = /turf/simulated/floor/colored
	objects_max = 3

/obj/marker/generation/plant/nitrogen_flower
	object_to_place = /obj/structure/interactive/plant/nitrogen_flower
	turf_whitelist = /turf/simulated/floor/colored/snow
	objects_max = 2

/obj/marker/generation/plant/oxygen_fruit
	object_to_place = /obj/structure/interactive/plant/oxygen_fruit
	turf_whitelist = /turf/simulated/floor/colored/snow
	objects_max = 2

/obj/marker/generation/plant/sugarcane
	object_to_place = /obj/structure/interactive/plant/sugarcane
	turf_whitelist = /turf/simulated/floor/colored/sand
	objects_max = 3

/obj/marker/generation/plant/tomato
	object_to_place = /obj/structure/interactive/plant/tomato
	turf_whitelist = /turf/simulated/floor/colored/grass
	objects_max = 1

/obj/marker/generation/plant/wheat
	object_to_place = /obj/structure/interactive/plant/wheat
	turf_whitelist = /turf/simulated/floor/colored/grass
	objects_max = 4

/obj/marker/generation/plant/polypore_mushroom
	object_to_place = /obj/structure/interactive/plant/polypore_mushroom
	turf_whitelist = /turf/simulated/floor/basalt
	objects_max = 4

/obj/marker/generation/plant/porcini_mushroom
	object_to_place = /obj/structure/interactive/plant/porcini_mushroom
	turf_whitelist = /turf/simulated/floor/basalt
	objects_max = 4

/obj/marker/generation/plant/inocybe_mushroom
	object_to_place = /obj/structure/interactive/plant/inocybe_mushroom
	turf_whitelist = /turf/simulated/floor/basalt
	objects_max = 4