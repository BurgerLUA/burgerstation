var/global/list/all_generation_markers = list()


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

	pixel_x = -32
	pixel_y = -32

	var/priority = 1

	var/flags_generation = FLAG_GENERATION_NONE

	var/bypass_disallow_generation = FALSE

	alpha = 100

	var/custom_object_to_place = FALSE

/obj/marker/generation/New(var/desired_loc)
	. = ..()
	all_generation_markers += src

/obj/marker/generation/PreDestroy()
	all_generation_markers -= src
	. = ..()


/obj/marker/generation/proc/get_object_to_place(var/turf/T,var/objects_placed=0,var/grow_left=0)
	CRASH("[src.type] was improperly setup with var custom_object_to_place!")

/obj/marker/generation/proc/generate_marker()

	var/turf/CT = get_turf(src)

	if(!CT)
		qdel(src)
		return FALSE

	var/desired_grow = 1 + rand(grow_amount_min,grow_amount_max)

	valid_turfs += CT

	while(objects_placed < objects_max && desired_grow > 0 && length(valid_turfs) > 0)
		var/turf/T = valid_turfs[1]
		valid_turfs -= T
		desired_grow--
		CHECK_TICK_HARD
		if(forbidden_turfs[T])
			continue
		forbidden_turfs[T] = TRUE //Already processed

		if(T != src.loc && !prob(hole_chance) && !ispath(object_to_place,T) && (!turf_whitelist || istype(T,turf_whitelist)))
			if(custom_object_to_place)
				var/atom/placed_object = get_object_to_place(T,objects_placed,desired_grow)
				if(!placed_object)
					break
			else
				new object_to_place(T)
			objects_placed += 1

		for(var/v in DIRECTIONS_CARDINAL)
			CHECK_TICK_HARD
			var/turf/T2 = get_step(T,v)
			if(!T2)
				continue
			if(forbidden_turfs[T2])
				continue
			if(T2.disallow_generation && !bypass_disallow_generation)
				forbidden_turfs[T2] = TRUE
				continue
			var/area/A = T2.loc
			if(flags_generation && (A.flags_generation & flags_generation))
				forbidden_turfs[T2] = TRUE
				continue
			if(prob(skip_chance))
				forbidden_turfs[T2] = TRUE
				continue
			if(ispathcache(object_to_place,/turf/))
				if(T.loc != T2.loc) //Different area.
					forbidden_turfs[T2] = TRUE //Already processed
					continue
			else
				if(!ignore_existing && T2.is_occupied())
					forbidden_turfs[T2] = TRUE //Already processed
					continue
			valid_turfs += T2

	qdel(src)

	return TRUE


