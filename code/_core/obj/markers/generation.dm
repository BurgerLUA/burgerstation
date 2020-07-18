/obj/marker/generation
	name = "generation marker"

	var/obj/object_to_place

	var/turf/list/valid_turfs = list()
	var/turf/list/forbidden_turfs = list()

	var/grow_amount_min = 2
	var/grow_amount_max = 10

	var/fade_chance = 10

	initialize_type = INITIALIZE_EARLY

/obj/marker/generation/proc/grow()

	for(var/turf/T in valid_turfs)
		valid_turfs -= T
		var/atom/movable/M = locate(object_to_place) in T.contents
		if(M) continue
		new object_to_place(T)
		for(var/k in DIRECTIONS_ALL)
			var/turf/T2 = get_step(T,k)
			if(T2.type != T.type)
				continue
			if(prob(fade_chance))
				forbidden_turfs[T2] = TRUE
			else if(!length(forbidden_turfs) || !forbidden_turfs[T2])
				valid_turfs += T2

/obj/marker/generation/Initialize()

	var/desired_grow = rand(grow_amount_min,grow_amount_max)

	valid_turfs += get_turf(src)

	while(desired_grow > 0)
		desired_grow--
		grow()

	. = ..()

	qdel(src)

	return .


/obj/marker/generation/grass
	object_to_place = /obj/structure/scenery/grass