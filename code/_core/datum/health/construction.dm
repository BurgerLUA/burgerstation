/health/construction/

	/*
	damage_base = list(  //Base armor for the mob.
		BLADE = INFINITY,
		BLUNT = INFINITY,
		PIERCE = INFINITY,
		LASER = INFINITY,
		ARCANE = INFINITY,
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

	var/old_damage_number = 0


/health/construction/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(. && health_current <= 0)
		var/atom/C = owner
		C.on_destruction(attacker,TRUE)

	return .


/health/construction/glass


/health/construction/glass/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(. && owner)
		var/damage_number = 3 - FLOOR((health_current/health_max)*3, 1)
		if(old_damage_number != damage_number)
			owner.update_sprite()
			old_damage_number = damage_number

	return .

/health/construction/glass/reinforced
