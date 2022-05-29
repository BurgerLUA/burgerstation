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

	var/priority = 1

	var/flags_generation = FLAG_GENERATION_NONE

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

