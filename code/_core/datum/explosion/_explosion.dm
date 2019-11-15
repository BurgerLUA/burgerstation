/explosion/
	name = "Explosion Tracker"

	var/list/explosion_data = list()

	var/step_num = 1

	var/atom/owner
	var/atom/source
	var/turf/epicenter

/explosion/New(var/turf/desired_loc,var/desired_range = 4,var/atom/desired_owner, var/atom/desired_source)

	. = ..()

	epicenter = desired_loc
	owner = desired_owner
	source = desired_source

	explosion_data = new/list(desired_range+1)

	spawn()
		for(var/turf/T in view(desired_range,desired_loc))
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

	var/explosion_length = length(explosion_data)

	for(var/turf/T in explosion_data[step_num])
		new/obj/explosion_particle(T)
		T.act_explode(owner,source,epicenter,explosion_length * (1 - (step_num/explosion_length)))
		sleep(-1)

	step_num++

	if(step_num > explosion_length)
		qdel(src)
		return FALSE

	return TRUE


proc/explode(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source)
	new/explosion(desired_turf,desired_range,desired_owner,desired_source)