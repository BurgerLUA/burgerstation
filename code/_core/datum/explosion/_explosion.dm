/proc/explode(var/turf/desired_turf,var/desired_range,var/atom/desired_owner,var/atom/desired_source,var/desired_loyalty)

	new /obj/effect/temp/explosion(desired_turf,SECONDS_TO_DECISECONDS(desired_range))

	play(pick('sound/effects/explosion/explosion_1.ogg','sound/effects/explosion/explosion_2.ogg','sound/effects/explosion/explosion_3.ogg'),desired_turf)

	FOR_DVIEW(var/turf/T,desired_range,desired_turf,0)
		CHECK_TICK
		var/distance = get_dist_real(T,desired_turf)
		if(distance > desired_range)
			continue
		new/obj/effect/explosion_particle(T)
		T.act_explode(desired_owner,desired_source,desired_turf,0.5 + ((1 + desired_range) - distance)*0.5,desired_loyalty)