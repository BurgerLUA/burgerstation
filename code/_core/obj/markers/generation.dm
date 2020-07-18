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

	pixel_x = -32
	pixel_y = -32

/obj/marker/generation/proc/grow(var/desired_grow)

	for(var/turf/T in valid_turfs)
		valid_turfs -= T
		if(length(forbidden_turfs) && forbidden_turfs[T])
			continue
		forbidden_turfs[T] = TRUE //Already processed

		if(!prob(hole_chance) && !ispath(object_to_place,T) && !T.world_spawn && !(turf_whitelist && !istype(T,turf_whitelist)))
			new object_to_place(T)
			objects_placed++

		for(var/k in DIRECTIONS_CARDINAL)
			var/turf/T2 = get_step(T,k)
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
				if(T2.is_occupied())
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
	object_to_place = /turf/simulated/floor/lava/
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

/obj/marker/generation/snow
	object_to_place = /turf/simulated/floor/colored/snow
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

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

/obj/marker/generation/basalt_wall
	object_to_place = /turf/simulated/wall/rock/basalt
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
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow


/obj/marker/generation/snow_tree
	object_to_place = /obj/structure/scenery/pinetrees
	grow_amount_min = 10
	grow_amount_max = 20
	objects_max = 12
	skip_chance = 0
	hole_chance = 90

	color = COLOR_GREEN

	turf_whitelist = /turf/simulated/floor/colored/snow
