/health/blob/

	resistance = list(
		BRUTE = 1,
		BURN = 1,
		TOX = 0,
		OXY = 0,
		FATIGUE = 0,
		PAIN=0,
		RAD=0,
		SANITY=0,
		MENTAL=0
	)

	armor_base = list(  //Base armor for the mob.,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		PAIN = INFINITY,
		SANITY = INFINITY
	)

/health/blob/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)
	. = ..()
	if(. && health_current <= 0)
		var/atom/C = owner
		C.on_destruction(attacker,TRUE)