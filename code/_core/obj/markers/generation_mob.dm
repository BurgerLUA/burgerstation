/obj/marker/generation/mob
	grow_amount_min = 50
	grow_amount_max = 10
	objects_max = 3
	skip_chance = 90
	hole_chance = 50

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
	turf_whitelist = /turf/simulated/liquid/lava/

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

/obj/marker/generation/mob/brown_bear
	object_to_place = /mob/living/simple/bear
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

/obj/marker/generation/mob/carp
	object_to_place = /mob/living/simple/spacecarp/
	objects_max = 1
	turf_whitelist = /turf/simulated/liquid/water

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

/obj/marker/generation/mob/legion/snow
	object_to_place = /mob/living/simple/legionare/snow
	objects_max = 1


/obj/marker/generation/mob/ash_walker
	object_to_place = /mob/living/advanced/npc/ashwalker/hunter
	objects_max = 1
	turf_whitelist = /turf/simulated/wall/ash