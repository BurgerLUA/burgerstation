proc/explode(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source)

	new /obj/effect/temp/explosion(desired_turf,SECONDS_TO_DECISECONDS(desired_range))

	FOR_DVIEW(var/turf/T,desired_range,desired_turf,0)
		CHECK_TICK
		var/distance = get_dist_real(T,desired_turf)
		if(distance > desired_range)
			continue
		new/obj/effect/explosion_particle(T)
		T.act_explode(desired_owner,desired_source,desired_turf,desired_range * (desired_range - distance))