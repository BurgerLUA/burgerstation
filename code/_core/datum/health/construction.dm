/health/construction/

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

	var/old_damage_number = 0


/health/construction/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && health_current <= 0)
		var/obj/structure/interactive/construction/C = owner
		C.on_destruction(attacker,TRUE)

	return .


/health/construction/glass


/health/construction/glass/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(. && owner)
		var/damage_number = 3 - FLOOR((health_current/health_max)*3, 1)
		if(old_damage_number != damage_number)
			owner.update_sprite()
			old_damage_number = damage_number

	return .

/health/construction/glass/reinforced
