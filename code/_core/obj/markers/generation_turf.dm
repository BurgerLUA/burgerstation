

var/global/list/obj/marker/smart_clear_turf/smart_clear_turfs = list()

/obj/marker/smart_clear_turf/
	var/checks_allowed = 40

/obj/marker/smart_clear_turf/large
	checks_allowed = 80

/obj/marker/smart_clear_turf/New(var/desired_loc)
	smart_clear_turfs += src
	. = ..()

/obj/marker/smart_clear_turf/PreDestroy()
	smart_clear_turfs -= src

	. = ..()


/obj/marker/smart_clear_turf/proc/process()

	. = 0

	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return .

	var/list/turfs_to_check = list(current_turf)
	var/list/turf_blacklist = list(current_turf=TRUE,null=TRUE)

	while(length(turfs_to_check) && checks_allowed > 0)
		CHECK_TICK_HARD
		checks_allowed--
		for(var/k in turfs_to_check)
			CHECK_TICK_HARD
			turfs_to_check -= k
			var/turf/simulated/T = k
			var/turf/DT = T.destruction_turf
			if(!T.map_spawn && T.density && T.health && DT && !initial(DT.density))
				T.change_turf(DT)
				. += 1
			else if(current_turf != T)
				continue
			for(var/d in DIRECTIONS_CARDINAL)
				CHECK_TICK_HARD
				var/turf/simulated/T2 = get_step(T,d)
				if(turf_blacklist[T2])
					continue
				if(!istype(T2))
					continue
				turf_blacklist[T2] = TRUE
				if(prob(get_dist(current_turf,T2)*20 - 80))
					continue
				turfs_to_check += T2


/obj/marker/generation/turf/
	priority = 1

/obj/marker/generation/turf/lava
	object_to_place = /turf/simulated/liquid/lava
	grow_amount_min = 25
	grow_amount_max = 50
	objects_max = 50
	skip_chance = 25
	hole_chance = 5

	color = COLOR_ORANGE

/obj/marker/generation/turf/lava/floor_only
	object_to_place = /turf/simulated/liquid/lava
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 30
	skip_chance = 0
	hole_chance = 0

	color = COLOR_ORANGE

	turf_whitelist = /turf/simulated/floor

/obj/marker/generation/turf/lava/small
	grow_amount_min = 10
	grow_amount_max = 25

/obj/marker/generation/turf/ash_floor
	object_to_place = /turf/simulated/floor/colored/ash/volcanic
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 10
	hole_chance = 0

	color = COLOR_GREY

/obj/marker/generation/turf/ash_wall
	object_to_place = /turf/simulated/wall/ash/volcanic
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 10
	hole_chance = 0

	color = COLOR_GREY


/obj/marker/generation/turf/ice
	object_to_place = /turf/simulated/floor/ice
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 25
	skip_chance = 25
	hole_chance = 5

	color = COLOR_CYAN

/obj/marker/generation/turf/water
	object_to_place = /turf/simulated/liquid/water/river
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 10
	skip_chance = 25
	hole_chance = 5

	color = COLOR_CYAN

/obj/marker/generation/turf/water/jungle
	objects_max = 15
	object_to_place = /turf/simulated/liquid/water/river/jungle

/obj/marker/generation/turf/water/desert
	skip_chance = 0
	hole_chance = 0
	objects_max = 15
	object_to_place = /turf/simulated/liquid/water/desert


/obj/marker/generation/turf/beach_sand
	object_to_place = /turf/simulated/floor/colored/sand/beach
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 15
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

/obj/marker/generation/turf/snow
	object_to_place = /turf/simulated/floor/colored/snow
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

/obj/marker/generation/turf/jungle_grass
	object_to_place = /turf/simulated/floor/colored/grass/jungle
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_WHITE

/obj/marker/generation/turf/jungle_dirt
	object_to_place = /turf/simulated/floor/colored/dirt/jungle
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/forest_dirt
	object_to_place = /turf/simulated/floor/colored/dirt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 10
	skip_chance = 10
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/forest_soil
	object_to_place = /turf/simulated/floor/colored/dirt/soil
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 10
	skip_chance = 10
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/cave_dirt
	object_to_place = /turf/simulated/floor/cave_dirt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/cave_dirt_colored
	object_to_place = /turf/simulated/floor/colored/dirt/cave
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/snow_dirt
	object_to_place = /turf/simulated/floor/colored/dirt/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_BROWN

/obj/marker/generation/turf/basalt
	object_to_place = /turf/simulated/floor/basalt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 25
	skip_chance = 25
	hole_chance = 25

	color = COLOR_GREY_DARK

/obj/marker/generation/turf/basalt/island
	grow_amount_min = 32
	grow_amount_max = 128
	hole_chance = 0
	skip_chance = 10
	objects_max = 64

/obj/marker/generation/turf/rock_wall
	object_to_place = /turf/simulated/wall/rock
	grow_amount_min = 15
	grow_amount_max = 30
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK


/obj/marker/generation/turf/rock_wall/small
	objects_max = 10
	skip_chance = 10


/obj/marker/generation/turf/basalt_wall
	object_to_place = /turf/simulated/wall/rock/basalt
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK

/obj/marker/generation/turf/jungle_wall
	object_to_place = /turf/simulated/wall/rock/moss
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY_DARK

/obj/marker/generation/turf/snow_wall
	object_to_place = /turf/simulated/wall/rock/snow
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 25
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY

/obj/marker/generation/turf/snow_wall/small
	objects_max = 15


/obj/marker/generation/turf/desert_wall
	object_to_place = /turf/simulated/wall/rock/desert
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

	color = COLOR_GREY