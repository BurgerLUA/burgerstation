/explosion/
	name = "Explosion Tracker"

	var/list/explosion_data = list()

	var/step_num = 1


/explosion/New(var/turf/desired_loc,var/desired_range = 4)

	. = ..()

	explosion_data = new/list(desired_range+1)

	spawn()
		for(var/turf/T in range(desired_range,desired_loc))
			var/distance = get_dist(T,desired_loc) + 1
			if(distance <= 0)
				distance = 1

			if(!explosion_data[distance])
				explosion_data[distance] = list()
			explosion_data[distance] += T
			sleep(-1)

	active_explosions += src

	return .


/explosion/destroy()
	active_explosions -= src
	return ..()


/explosion/proc/process()

	for(var/turf/T in explosion_data[step_num])
		new/obj/effect/temp/sparkles(T)
		sleep(-1)

	step_num++

	if(step_num > length(explosion_data))
		qdel(src)
		return FALSE

	return TRUE


proc/explode(var/turf/desired_turf,var/desired_range)
	new/explosion(desired_turf,desired_range)