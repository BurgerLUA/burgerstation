/obj/marker/generation
	name = "generation marker"

	var/atom/object_to_place

	var/turf/list/valid_turfs = list()
	var/turf/list/forbidden_turfs = list()

	var/grow_amount_min = 2
	var/grow_amount_max = 10

	var/objects_placed = 0
	var/objects_max = 50

	var/skip_chance = 25 //Higher values makes it look less circular.
	var/hole_chance = 5 //Higher values make it look more like swiss cheese.

/obj/marker/generation/proc/grow(var/desired_grow)

	for(var/turf/T in valid_turfs)
		valid_turfs -= T
		if(length(forbidden_turfs) && forbidden_turfs[T])
			continue
		forbidden_turfs[T] = TRUE //Already processed

		if(!prob(hole_chance) && !ispath(object_to_place,T))
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
	object_to_place = /turf/simulated/floor/sand/
	grow_amount_min = 10
	grow_amount_max = 30
	objects_max = 100


/obj/marker/generation/basalt
	object_to_place = /turf/simulated/floor/basalt
	grow_amount_min = 5
	grow_amount_max = 10
	objects_max = 50
	skip_chance = 25
	hole_chance = 0

/obj/marker/generation/basalt_wall
	object_to_place = /turf/simulated/wall/rock/basalt
	grow_amount_min = 5
	grow_amount_max = 8
	objects_max = 50
	skip_chance = 25
	hole_chance = 0