/health/turf/

	armor_base = list(  //Base armor for the mob.
		BLADE = 50,
		BLUNT = 0,
		PIERCE = 25,
		LASER = 25,
		MAGIC = 25,
		HEAT = 0,
		COLD = 50,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)


/health/turf/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && health_current <= 0 && is_simulated(owner))
		var/turf/simulated/T = owner
		T.on_destruction(attacker,TRUE)

	return .


