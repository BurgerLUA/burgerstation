#define HEALTH_PRECISION 0.01

/health/

	var/atom/owner // The owner of this health object

	var/health_max = -1
	var/health_current = -1
	var/health_regeneration = -1
	var/health_regen_cooef = 1 //What percentage to naturally regenerate health.

	var/stamina_max = -1
	var/stamina_current = -1
	var/stamina_regeneration = -1
	var/stamina_regen_cooef = 1 //What percentage to naturally regenerate stamina.

	var/mana_max = -1
	var/mana_current = -1
	var/mana_regeneration = -1
	var/mana_regen_cooef = 1 //What percentage to naturally regenerate mana.

	var/list/damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0, SANITY=0, MENTAL=0)

	var/list/max_damage = list(PAIN=100) //Maximum damage this health object can take.

	var/list/resistance = list() //How much to multiply damage

	var/armor/armor

	var/organic = FALSE

/health/Destroy()
	owner = null
	return ..()

/health/proc/get_damage_multiplier()
	return 1

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

/health/proc/update_health_stats()
	health_max = owner.health_base
	stamina_max = owner.stamina_base
	mana_max = owner.mana_base

/health/proc/get_overall_health(var/includes_fatigue = FALSE,var/include_pain=FALSE,var/include_sanity=FALSE)
	return health_max - get_total_loss(includes_fatigue,include_pain,include_sanity)

/health/proc/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0, SANITY=0, MENTAL=0)
	update_health()
	return TRUE

/health/proc/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)

	//Living beings don't use the code below.
	//They get their own custom thing.

	if(src.organic && !organic)
		return 0

	if(!src.organic && !robotic)
		return 0

	. = 0

	var/should_update = FALSE

	if(brute) . += adjust_loss(BRUTE,brute); should_update = TRUE
	if(burn) . += adjust_loss(BURN,burn); should_update = TRUE
	if(tox) . += adjust_loss(TOX,tox); should_update = TRUE
	if(oxy) . += adjust_loss(OXY,oxy); should_update = TRUE
	if(pain) . += adjust_loss(PAIN,pain); should_update = TRUE
	if(rad) . += adjust_loss(RAD,rad); should_update = TRUE
	if(fatigue) . += adjust_loss(FATIGUE,fatigue); should_update = TRUE
	if(sanity) . += adjust_loss(SANITY,sanity); should_update = TRUE
	if(mental) . += adjust_loss(MENTAL,mental); should_update = TRUE

	if(update && should_update)
		update_health()

/health/proc/adjust_loss(var/loss_type,var/value)
	if(resistance[loss_type] && value > 0) value *= resistance[loss_type]
	value -= min(0,damage[loss_type] + value)
	damage[loss_type] += FLOOR(value,HEALTH_PRECISION)
	if(max_damage[loss_type])
		damage[loss_type] = min(damage[loss_type],max_damage[loss_type])
	return value

/health/proc/get_total_loss(var/include_fatigue = TRUE,var/include_pain=TRUE,var/include_sanity=TRUE)

	var/list/damage_list = damage.Copy()
	if(!include_fatigue)
		damage_list -= FATIGUE
	if(!include_pain)
		damage_list -= PAIN
	if(!include_sanity)
		damage_list -= SANITY

	. = 0
	for(var/damage_type in damage_list)
		. += damage[damage_type]

/health/proc/get_loss(var/damage_type)
	return damage[damage_type]

/health/proc/get_stamina_loss()
	return stamina_max - stamina_current

/health/proc/get_mana_loss()
	return mana_max - mana_current

/health/proc/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE) //Update the health values.
	health_current = get_overall_health(FALSE,FALSE,FALSE)
	return TRUE

/health/proc/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)
	var/armor/A = ARMOR(armor)
	if(!A)
		return list()
	return A.defense_rating.Copy()

/health/proc/adjust_mana(var/adjust_value)
	var/old_value = mana_current
	var/new_value = clamp(mana_current + adjust_value,0,mana_max)
	new_value = FLOOR(new_value,HEALTH_PRECISION)
	if(old_value != new_value)
		mana_current = new_value
		return new_value - old_value
	return FALSE

/health/proc/adjust_stamina(var/adjust_value)
	var/old_value = stamina_current
	var/new_value = clamp(stamina_current + adjust_value,0,stamina_max)
	new_value = FLOOR(new_value,HEALTH_PRECISION)
	if(old_value != new_value)
		stamina_current = new_value
		return new_value - old_value
	return FALSE


/health/proc/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)
	return TRUE