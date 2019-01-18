/atom/proc/get_overall_health()
	return health_max - get_total_loss()

//Setting
/atom/proc/set_brute_loss(var/value)
	damage[BRUTE] = value
	update_damage_overlays()
	update_health()
	return value

/atom/proc/set_burn_loss(var/value)
	damage[BURN] = value
	update_damage_overlays()
	update_health()
	return value

/atom/proc/set_tox_loss(var/value)
	damage[TOX] = value
	update_damage_overlays()
	update_health()
	return value

/atom/proc/set_oxy_loss(var/value)
	damage[OXY] = value
	update_damage_overlays()
	update_health()
	return value

//Adding/Subtracting
/atom/proc/adjust_brute_loss(var/value)
	damage[BRUTE] += value - resistance[BRUTE]
	update_damage_overlays()
	update_health()
	return value

/atom/proc/adjust_burn_loss(var/value)
	damage[BURN] += value - resistance[BURN]
	update_damage_overlays()
	update_health()
	return value

/atom/proc/adjust_tox_loss(var/value)
	damage[TOX] += value - resistance[TOX]
	update_damage_overlays()
	update_health()
	return value

/atom/proc/adjust_oxy_loss(var/value)
	damage[OXY] += value - resistance[OXY]
	update_damage_overlays()
	update_health()
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

/atom/proc/update_damage_overlays()
	//Update your overlays here.

/atom/proc/update_health() //Update the health values.
	health_current = get_overall_health()

mob/living/advanced/update_health()
	health_max = 0
	health_current = 0
	for(var/obj/item/organ/O in organs)
		health_current += O.get_overall_health()
		health_max += O.health_max

	update_icon()
	update_health_elemement_icons()
