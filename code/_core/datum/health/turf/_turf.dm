/health/turf/

	/*
	armor_base = list(  //Base armor for the mob.
		BLADE = 50,
		BLUNT = 0,
		PIERCE = 25,
		LASER = 25,
		ARCANE = 25,
		HEAT = 0,
		COLD = 50,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = INFINITY,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)
	*/

/health/turf/Initialize()

	if(isturf(owner))
		var/turf/T = owner
		if(T.material_id)
			var/material/M = SSmaterials.all_materials[T.material_id]
			if(M && M.armor)
				armor_base = M.armor.Copy()

	return ..()

/health/turf/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(. && health_current <= 0 && is_simulated(owner))
		var/turf/simulated/T = owner
		T.on_destruction(attacker,TRUE)

	return .


