/health/turf/

	/*
	damage_base = list(  //Base armor for the mob.
		BLADE = INFINITY,
		BLUNT = INFINITY,
		PIERCE = INFINITY,
		LASER = INFINITY,
		MAGIC = INFINITY,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)
	*/


/health/turf/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && health_current <= 0 && is_simulated(owner))
		var/turf/simulated/T = owner
		T.on_destruction(attacker,TRUE)

	return .


