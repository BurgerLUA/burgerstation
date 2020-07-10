/health/

	var/atom/owner // The owner of this health object

	var/health_max = -1
	var/health_current = -1
	var/health_regeneration = -1

	var/stamina_max = -1
	var/stamina_current = -1
	var/stamina_regeneration = -1

	var/mana_max = -1
	var/mana_current = -1
	var/mana_regeneration = -1

	var/damage_multiplier = 1 //How much damage, multiplied, does this atom receive?

	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0)
	var/list/resistance = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0) //How much to subtract damage
	var/list/wound/wounds = list()

	var/list/armor_base = list(  //Base armor for the mob.
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

/health/New(var/desired_owner)
	owner = desired_owner
	return ..()

/health/Initialize()

	update_health_stats()

	health_current = health_max
	stamina_current = stamina_max
	mana_current = mana_max

	update_health(update_hud = FALSE)

	return ..()

/health/Destroy()

	/*
	for(var/wound/W in wounds)
		qdel(W)

	wounds.Cut()
	*/

	owner = null

	return ..()

/health/proc/update_health_stats()
	health_max = owner.health_base
	stamina_max = owner.stamina_base
	mana_max = owner.mana_base

/health/proc/get_overall_health(var/includes_fatigue = FALSE)
	return health_max - get_total_loss(includes_fatigue)

//Setting
/health/proc/set_brute_loss(var/value)
	damage[BRUTE] = value
	return value

/health/proc/set_burn_loss(var/value)
	damage[BURN] = value
	return value

/health/proc/set_tox_loss(var/value)
	damage[TOX] = value
	return value

/health/proc/set_oxy_loss(var/value)
	damage[OXY] = value
	return value

/health/proc/set_fatigue_loss(var/value)
	damage[FATIGUE] = value
	return value

/health/proc/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0)
	update_health(TRUE)
	return TRUE

/health/proc/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/update=TRUE)

	var/total_loss = 0

	if(brute)
		brute -= (brute > 0 ? resistance[BRUTE] : 0)
		brute -= min(0,damage[BRUTE] + brute)
		damage[BRUTE] += brute
		total_loss += brute

	if(burn)
		burn -= (burn > 0 ? resistance[BURN] : 0)
		burn -= min(0,damage[BURN] + burn)
		damage[BURN] += burn
		total_loss += burn

	if(tox)
		tox -= (tox > 0 ? resistance[TOX] : 0)
		tox -= min(0,damage[TOX] + tox)
		damage[TOX] += tox
		total_loss += tox

	if(oxy)
		oxy -= (oxy > 0 ? resistance[OXY] : 0)
		oxy -= min(0,damage[OXY] + oxy)
		damage[OXY] += oxy
		total_loss += oxy

	if(update && total_loss)
		update_health()

	return total_loss

//Adding/Subtracting
/health/proc/adjust_brute_loss(var/value)
	value -= (value > 0 ? resistance[BRUTE] : 0)
	value -= min(0,damage[BRUTE] + value)
	damage[BRUTE] += value
	return value

/health/proc/adjust_burn_loss(var/value)
	value -= (value > 0 ? resistance[BURN] : 0)
	value -= min(0,damage[BURN] + value)
	damage[BURN] += value
	return value

/health/proc/adjust_tox_loss(var/value)
	value -= (value > 0 ? resistance[TOX] : 0)
	value -= min(0,damage[TOX] + value)
	damage[TOX] += value
	return value

/health/proc/adjust_oxy_loss(var/value)
	value -= (value > 0 ? resistance[OXY] : 0)
	value -= min(0,damage[OXY] + value)
	damage[OXY] += value
	return value

/health/proc/adjust_fatigue_loss(var/value)
	value -= (value > 0 ? resistance[FATIGUE] : 0)
	value -= min(0,damage[FATIGUE] + value)
	damage[FATIGUE] += value
	return value

/health/proc/get_total_loss(var/include_fatigue = TRUE)
	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		returning_value += damage[damage_type]

	return returning_value

//Retrieving
/health/proc/get_brute_loss()
	return damage[BRUTE]

/health/proc/get_burn_loss()
	return damage[BURN]

/health/proc/get_tox_loss()
	return damage[TOX]

/health/proc/get_oxy_loss()
	return damage[OXY]

/health/proc/get_fatigue_loss()
	return damage[FATIGUE]

/health/proc/get_loss(var/damage_type)
	return damage[damage_type]

/health/proc/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE) //Update the health values.
	health_current = get_overall_health()
	return TRUE

/health/proc/adjust_loss(var/type=BRUTE,var/amount)
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

/health/proc/get_defense(var/atom/attacker,var/atom/hit_object)
	var/returning_value = list()
	for(var/damage_type in src.armor_base)
		var/damage_amount = src.armor_base[damage_type]
		returning_value[damage_type] = damage_amount
	return returning_value

/health/mob/living/get_defense(var/atom/attacker,var/atom/hit_object)
	if(!is_living(owner))
		return ..()
	return armor_base.Copy()

/health/proc/adjust_mana(var/adjust_value)
	var/old_value = mana_current
	var/new_value = clamp(mana_current + adjust_value,0,mana_max)
	if(old_value != new_value)
		mana_current = new_value
		return new_value - old_value
	return FALSE

/health/proc/adjust_stamina(var/adjust_value)
	var/old_value = stamina_current
	var/new_value = clamp(stamina_current + adjust_value,0,stamina_max)
	if(old_value != new_value)
		stamina_current = new_value
		return new_value - old_value
	return FALSE