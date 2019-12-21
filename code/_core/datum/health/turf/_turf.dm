/health/turf/
	name = "turf health"

	armor_base = list(  //Base armor for the mob.
		BLADE = ARMOR_C,
		BLUNT = 0,
		PIERCE = ARMOR_C,
		LASER = 0,
		MAGIC = 0,
		HEAT = ARMOR_C,
		COLD = ARMOR_C,
		BOMB = 0,
		BIO = ARMOR_X,
		RAD = ARMOR_X,
		HOLY = ARMOR_X,
		DARK = ARMOR_X,
		FATIGUE = ARMOR_X
	)


/health/turf/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(health_current <= 0 && is_simulated(owner))
		var/turf/simulated/T = owner
		T.on_destruction(TRUE)

	return .


