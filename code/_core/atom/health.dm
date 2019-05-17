/atom/proc/get_overall_health()
	return health_max - get_total_loss()

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

/atom/proc/get_total_loss()
	return get_brute_loss() + get_burn_loss() + get_tox_loss() + get_oxy_loss()

//Retrieving
/atom/proc/get_brute_loss()
	return damage[BRUTE]

/atom/proc/get_burn_loss()
	return damage[BURN]

/atom/proc/get_tox_loss()
	return damage[TOX]

/atom/proc/get_oxy_loss()
	return damage[OXY]

/atom/proc/update_health(var/damage_dealt) //Update the health values.
	health_current = get_overall_health()

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
