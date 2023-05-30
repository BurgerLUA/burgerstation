/obj/marker/generation/foliage
	object_to_place = /obj/structure/scenery/bush/grass
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 5
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

	priority = 2

	bypass_disallow_generation = TRUE

/obj/marker/generation/foliage/bushes/
	objects_max = 2
	hole_chance = 95
	skip_chance = 50

/obj/marker/generation/foliage/bushes/fern
	object_to_place = /obj/structure/scenery/bush/fern
	turf_whitelist = /turf/simulated/floor/grass/jungle

/obj/marker/generation/foliage/bushes/generic
	object_to_place = /obj/structure/scenery/bush/generic
	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/foliage/bushes/grass
	object_to_place = /obj/structure/scenery/bush/grass
	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/foliage/bushes/leafy
	object_to_place = /obj/structure/scenery/bush/leafy
	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/foliage/bushes/pale
	object_to_place = /obj/structure/scenery/bush/pale
	turf_whitelist = /turf/simulated/floor/grass/jungle

/obj/marker/generation/foliage/bushes/pointy
	object_to_place = /obj/structure/scenery/bush/pointy
	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/foliage/bushes/snow
	object_to_place = /obj/structure/scenery/bush/snow
	turf_whitelist = /turf/simulated/floor/colored

/obj/marker/generation/foliage/bushes/stalk
	object_to_place = /obj/structure/scenery/bush/stalk
	turf_whitelist = /turf/simulated/liquid/water

/obj/marker/generation/foliage/bushes/stick //firstbush
	object_to_place = /obj/structure/scenery/bush/stick
	turf_whitelist = /turf/simulated/floor/grass/jungle

/obj/marker/generation/foliage/bushes/sun
	object_to_place = /obj/structure/scenery/bush/sun


//GRASS
/obj/marker/generation/foliage/grass
	object_to_place = /obj/structure/scenery/grass/normal
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass

/obj/marker/generation/foliage/grass/snow
	object_to_place = /obj/structure/scenery/grass/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 50
	hole_chance = 10

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow

/obj/marker/generation/foliage/grass/jungle
	object_to_place = /obj/structure/scenery/grass/jungle
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 30
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle


/obj/marker/generation/foliage/grass/jungle/rock
	object_to_place = /obj/structure/scenery/grass/jungle_rock
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 10
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass

//TREES
/obj/marker/generation/foliage/tree
	object_to_place = /obj/structure/interactive/tree/evergreen
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 10
	skip_chance = 50
	hole_chance = 50

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored

	bypass_disallow_generation = FALSE


/obj/marker/generation/foliage/tree/snow
	object_to_place = /obj/structure/interactive/tree/pine

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow



/obj/marker/generation/foliage/tree/jungle
	object_to_place = /obj/structure/interactive/tree/jungle_large
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 2
	skip_chance = 10
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle


//Flowers
/obj/marker/generation/foliage/flowers
	object_to_place = /obj/structure/scenery/flowers
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 4
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass


/obj/marker/generation/foliage/flowers/lavender
	object_to_place = /obj/structure/scenery/grass/lavender
	grow_amount_min = 4
	grow_amount_max = 6
	objects_max = 20
	skip_chance = 25
	hole_chance = 5

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/grass


/obj/marker/generation/foliage/tree/jungle/small
	object_to_place = /obj/structure/interactive/tree/jungle_small
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 5
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/grass/jungle


//Jungle lights.
/obj/marker/generation/foliage/jungle_light/flower
	object_to_place = /obj/structure/interactive/lighting/jungle/flower
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 2
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle



/obj/marker/generation/foliage/jungle_light/stick
	object_to_place = /obj/structure/interactive/lighting/jungle/stick
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 4
	skip_chance = 10
	hole_chance = 20

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle



/obj/marker/generation/foliage/jungle_light/lamp
	object_to_place = /obj/structure/interactive/lighting/jungle/lamp
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 3
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle



/obj/marker/generation/foliage/jungle_light/mine
	object_to_place = /obj/structure/interactive/lighting/jungle/mine
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 2
	skip_chance = 50
	hole_chance = 90

	color = COLOR_PINK

	turf_whitelist = /turf/simulated/floor/grass/jungle
