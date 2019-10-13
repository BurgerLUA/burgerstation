/atom/proc/get_overall_health(var/includes_fatigue = FALSE)
	return health_max - get_total_loss(includes_fatigue)

//Setting
/atom/proc/set_brute_loss(var/value)
	damage[BRUTE] = value
	return value

/atom/proc/set_burn_loss(var/value)
	damage[BURN] = value
	return value

/atom/proc/set_tox_loss(var/value)
	damage[TOX] = value
	return value

/atom/proc/set_oxy_loss(var/value)
	damage[OXY] = value
	return value

/atom/proc/set_fatigue_loss(var/value)
	damage[FATIGUE] = value
	return value

//Adding/Subtracting
/atom/proc/adjust_brute_loss(var/value)
	value -= (value > 0 ? resistance[BRUTE] : 0)
	value -= min(0,damage[BRUTE] + value)
	damage[BRUTE] += value
	return value

/atom/proc/adjust_burn_loss(var/value)
	value -= (value > 0 ? resistance[BURN] : 0)
	value -= min(0,damage[BURN] + value)
	damage[BURN] += value
	return value

/atom/proc/adjust_tox_loss(var/value)
	value -= (value > 0 ? resistance[TOX] : 0)
	value -= min(0,damage[TOX] + value)
	damage[TOX] += value
	return value

/atom/proc/adjust_oxy_loss(var/value)
	value -= (value > 0 ? resistance[OXY] : 0)
	value -= min(0,damage[OXY] + value)
	damage[OXY] += value
	return value

/atom/proc/adjust_fatigue_loss(var/value)
	value -= (value > 0 ? resistance[FATIGUE] : 0)
	value -= min(0,damage[FATIGUE] + value)
	damage[FATIGUE] += value
	return value

/atom/proc/get_total_loss(var/include_fatigue = TRUE)
	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		returning_value += damage[damage_type]

	return returning_value

/atom/proc/get_total_loss_soft(var/include_fatigue = TRUE)
	var/returning_value = 0
	for(var/damage_type in damage_soft)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		returning_value += damage_soft[damage_type]

	return returning_value

//Retrieving
/atom/proc/get_brute_loss()
	return damage[BRUTE]

/atom/proc/get_burn_loss()
	return damage[BURN]

/atom/proc/get_tox_loss()
	return damage[TOX]

/atom/proc/get_oxy_loss()
	return damage[OXY]

/atom/proc/get_fatigue_loss()
	return damage[FATIGUE]

/atom/proc/get_loss(var/damage_type)
	return damage[damage_type]

/atom/proc/update_health(var/damage_dealt,var/atom/attacker) //Update the health values.
	health_current = get_overall_health()
	damage_soft_total = get_total_loss_soft()

/atom/proc/adjust_loss(var/type=BRUTE,var/amount)
	if(!amount)
		return FALSE
	switch(type)
		if(BRUTE)
			return adjust_brute_loss(amount)
		if(BURN)
			return adjust_burn_loss(amount)
		if(TOX)
			return adjust_tox_loss(amount)
		if(OXY)
			return adjust_oxy_loss(amount)
		if(FATIGUE)
			return adjust_fatigue_loss(amount)

/atom/proc/do_impact_effect(var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/damage_dealt)
	return TRUE