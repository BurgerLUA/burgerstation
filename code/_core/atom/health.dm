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
	damage[BRUTE] += value - resistance[BRUTE]
	return value

/atom/proc/adjust_burn_loss(var/value)
	damage[BURN] += value - resistance[BURN]
	return value

/atom/proc/adjust_tox_loss(var/value)
	damage[TOX] += value - resistance[TOX]
	return value

/atom/proc/adjust_oxy_loss(var/value)
	damage[OXY] += value - resistance[OXY]
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

mob/living/advanced/update_health(var/damage_dealt)

	health_max = 100 + get_attribute_power(ATTRIBUTE_VITALITY,0,100)*400
	health_regeneration = get_attribute_power(ATTRIBUTE_VITALITY,0,100)*0.125

	stamina_max = 100 + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*400
	stamina_regeneration = 0.2 + get_attribute_power(ATTRIBUTE_AGILITY,0,100)*4

	mana_max = 100 + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*400
	mana_regeneration = 0.1 + get_attribute_power(ATTRIBUTE_WILLPOWER,0,100)*2

	health_current = 0

	var/damage_current = 0
	for(var/obj/item/organ/O in organs)
		damage_current += O.get_total_loss()
		stamina_max += O.stamina_max
		mana_max += O.mana_max

	health_current = health_max - damage_current

	update_icon()
	update_health_elemement_icons()

	if(health_current <= 0)
		death()
