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

	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0)
	var/list/resistance = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0) //How much to subtract damage
	var/list/wound/wounds = list()

	var/list/armor_base = list(  //Base armor for the mob.
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0,
		PAIN = 0
	)

	var/organic = FALSE

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
	for(var/k in wounds)
		var/wound/W = k
		qdel(W)

	wounds.Cut()
	*/

	owner = null

	return ..()

/health/proc/update_health_stats()
	health_max = owner.health_base
	stamina_max = owner.stamina_base
	mana_max = owner.mana_base

/health/proc/get_overall_health(var/includes_fatigue = FALSE,var/include_pain=FALSE)
	return health_max - get_total_loss(includes_fatigue,include_pain)

/health/proc/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN = 0, RAD = 0)
	update_health(update_hud = TRUE)
	return TRUE

/health/proc/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/pain,var/rad,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	if(src.organic && !organic)
		return 0

	if(!src.organic && !robotic)
		return 0

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

	if(pain)
		pain -= (pain > 0 ? resistance[PAIN] : 0)
		pain -= min(0,damage[PAIN] + pain)
		damage[PAIN] += pain
		total_loss += pain

	if(rad)
		rad -= (rad > 0 ? resistance[RAD] : 0)
		rad -= min(0,damage[RAD] + rad)
		damage[RAD] += rad
		total_loss += rad

	if(update && total_loss)
		update_health()

	return total_loss

/health/proc/adjust_fatigue_loss(var/value)
	value -= (value > 0 ? resistance[FATIGUE] : 0)
	value -= min(0,damage[FATIGUE] + value)
	damage[FATIGUE] += value
	return value

/health/proc/get_total_loss(var/include_fatigue = TRUE,var/include_pain=TRUE)
	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		if(!include_pain && damage_type == PAIN)
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

/health/proc/get_pain_loss()
	return damage[PAIN]

/health/proc/get_rad_loss()
	return damage[RAD]

/health/proc/get_loss(var/damage_type)
	return damage[damage_type]

/health/proc/get_stamina_loss()
	return stamina_max - stamina_current

/health/proc/get_mana_loss()
	return mana_max - mana_current

/health/proc/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE) //Update the health values.
	health_current = get_overall_health(FALSE,FALSE)
	return TRUE

/health/proc/get_defense(var/atom/attacker,var/atom/hit_object)
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