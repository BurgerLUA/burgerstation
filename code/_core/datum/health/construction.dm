/health/construction/

	/*
	armor_base = list(  //Base armor for the mob.
		BLADE = ARMOR_X,
		BLUNT = ARMOR_X,
		PIERCE = ARMOR_X,
		LASER = ARMOR_X,
		MAGIC = ARMOR_X,
		HEAT = ARMOR_X,
		COLD = ARMOR_X,
		BOMB = 0,
		BIO = ARMOR_X,
		RAD = ARMOR_X,
		HOLY = ARMOR_X,
		DARK = ARMOR_X,
		FATIGUE = ARMOR_X
	)
	*/


/health/construction/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(health_current <= 0)
		var/obj/structure/interactive/construction/C = owner
		C.on_destruction(attacker,TRUE)

	return .


