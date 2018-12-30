/atom/proc/get_overall_health()
	var/total_health = health_max
	for(var/key in damage)
		var/value = damage[key]
		total_health -= value

	return total_health

//Setting
/atom/proc/set_brute_loss(var/value)
	damage[BRUTE] = value
	update_damage_overlays()
	return value

/atom/proc/set_burn_loss(var/value)
	damage[BURN] = value
	update_damage_overlays()
	return value

/atom/proc/set_tox_loss(var/value)
	damage[TOX] = value
	update_damage_overlays()
	return value

/atom/proc/set_oxy_loss(var/value)
	damage[OXY] = value
	update_damage_overlays()
	return value

//Adding/Subtracting
/atom/proc/adjust_brute_loss(var/value)
	damage[BRUTE] += value - resistance[BRUTE]
	update_damage_overlays()
	return value

/atom/proc/adjust_burn_loss(var/value)
	damage[BURN] += value - resistance[BURN]
	update_damage_overlays()
	return value

/atom/proc/adjust_tox_loss(var/value)
	damage[TOX] += value - resistance[TOX]
	update_damage_overlays()
	return value

/atom/proc/adjust_oxy_loss(var/value)
	damage[OXY] += value - resistance[OXY]
	update_damage_overlays()
	return value

//Retrieving
/atom/proc/get_brute_loss(var/value)
	return damage[BRUTE]

/atom/proc/get_burn_loss(var/value)
	return damage[BURN]

/atom/proc/get_tox_loss(var/value)
	return damage[TOX]

/atom/proc/get_oxy_loss(var/value)
	return damage[OXY]

atom/proc/update_damage_overlays()
	//Update your overlays here.