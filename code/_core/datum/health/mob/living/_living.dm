/health/mob/living/
	var/has_bloodoxygen = TRUE
	organic = TRUE

/health/mob/living/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0, SANITY=0, MENTAL=0)
	var/mob/living/L = owner
	QUEUE_HEALTH_UPDATE(L)
	return TRUE

/health/mob/living/get_damage_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object)

	. = ..()

	var/mob/living/L = owner
	if(L.boss)
		var/multiplier_value = clamp(1.4 - length(L.players_fighting_boss)*0.1,0.25,1)
		. *= multiplier_value

	if(L.has_status_effect(STRESSED))
		. += 0.5

	if(L.minion_master)
		. += 1 //Take double damage for being a minion.

/health/mob/living/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)

	. = ..()

	var/mob/living/L = owner

	if(L.ckey_last)
		var/intoxication_bonus = FLOOR(L.intoxication*0.025,1)
		var/quality_bonus = FLOOR(max(L.get_nutrition_quality_mod() - 1,0)*50,1)
		var/fat_bonus = FLOOR(max(0,L.nutrition_normal + L.nutrition_fast + L.nutrition_quality - L.nutrition_max)*0.05,1)

		var/constitution_bonus = FLOOR(L.get_attribute_power(ATTRIBUTE_CONSTITUTION,0,1,2)*50,5) //Physical
		var/soul_bonus = FLOOR(L.get_attribute_power(ATTRIBUTE_SOUL,0,1,2)*50,1) //Magical

		var/status_bonus =  STATUS_EFFECT_MAGNITUDE(L,TEMP_ARMOR)

		var/list/bonus_armor = list(
			BLADE = quality_bonus + constitution_bonus + intoxication_bonus + status_bonus,
			BLUNT = quality_bonus + constitution_bonus + intoxication_bonus + status_bonus,
			PIERCE = quality_bonus + constitution_bonus + intoxication_bonus + status_bonus,
			LASER = quality_bonus - fat_bonus,
			ARCANE = quality_bonus + soul_bonus - intoxication_bonus - status_bonus,
			HEAT = quality_bonus - fat_bonus,
			COLD = intoxication_bonus + fat_bonus,
			SHOCK = quality_bonus,
			ACID = quality_bonus,
			BOMB = quality_bonus,
			BIO = quality_bonus,
			RAD = quality_bonus,
			HOLY = quality_bonus + soul_bonus - status_bonus,
			DARK = quality_bonus + soul_bonus - status_bonus,
			FATIGUE = quality_bonus + constitution_bonus - intoxication_bonus,
			PAIN = quality_bonus + constitution_bonus + intoxication_bonus,
			SANITY = quality_bonus + soul_bonus + intoxication_bonus
		)

		for(var/damage_type in bonus_armor)
			if(.[damage_type])
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += bonus_armor[damage_type]
			else
				.[damage_type] = bonus_armor[damage_type]

	for(var/list/bonus in L.defense_bonuses) //Superpowers and whatnot.
		for(var/damage_type in bonus)
			if(.[damage_type])
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += bonus[damage_type]
			else
				.[damage_type] = bonus[damage_type]


/health/mob/living/update_health()

	var/mob/living/L = owner

	if(has_bloodoxygen && L.blood_volume_max && L.blood_type)
		var/blood_oxygen = (L.blood_volume/L.blood_volume_max) + L.blood_oxygen
		damage[OXY] = CEILING(max(0,1 - blood_oxygen)*health_max*2,HEALTH_PRECISION)

	. = ..()

	if(!owner)
		return .

	//Regularcrit
	if(L.death_threshold < 0)
		var/should_be_in_crit = (health_current <= 0) && !L.status_effects[ADRENALINE]
		if(!L.status_effects[CRIT] && should_be_in_crit)
			L.add_status_effect(CRIT,-1,-1,force = TRUE)
			if(!L.dead && !L.status_effects[CRITPROTECTION] && L.is_player_controlled())
				L.add_status_effect(CRITPROTECTION,stealthy=TRUE)
		else if(L.status_effects[CRIT] && !should_be_in_crit)
			L.remove_status_effect(CRIT)

	//Paincrit
	var/should_be_in_paincrit = (damage[PAIN] - L.pain_regen_buffer) > 0 && (damage[PAIN] - L.pain_regen_buffer) >= health_current
	if(!L.status_effects[PAINCRIT] && should_be_in_paincrit)
		L.add_status_effect(PAINCRIT,-1,-1,force = TRUE)
	else if(L.status_effects[PAINCRIT] && !should_be_in_paincrit)
		L.remove_status_effect(PAINCRIT)

	//Death
	if(L.check_death())
		L.death()

	//HUD stuff.
	if(L.medical_hud_image)
		var/health_icon_state
		if(L.dead)
			if(L.suicide || !L.is_player_controlled())
				health_icon_state = "dead"
			else
				var/time_left = SScallback.all_callbacks["\ref[L]_make_unrevivable"] ? SScallback.all_callbacks["\ref[L]_make_unrevivable"]["time"] - world.time : 0
				if(time_left > 0)
					health_icon_state = "revive_[FLOOR((time_left/L.expiration_time)*3,1)]"
				else
					health_icon_state = "dead"
		else if (L.has_status_effect(CRIT))
			health_icon_state = "crit"
		else
			health_icon_state = "[clamp(FLOOR((health_current/health_max)*23, 1),0,23)]"

		L.medical_hud_image.icon_state = health_icon_state

	if(L.medical_hud_image_advanced)
		L.medical_hud_image_advanced.icon_state = "[damage[TOX] > 0][damage[BURN] > 0][damage[BRUTE] > 0]"

	for(var/k in L.stat_elements)
		var/obj/hud/button/stat/S = L.stat_elements[k]
		L.stat_elements_to_update[S] = TRUE

	L.update_boss_health()

/health/mob/living/update_health_stats()

	. = ..()

	var/mob/living/L = owner

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY,0,1,5)*L.health_base*2
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_ENDURANCE,0,1,5)*L.stamina_base*2
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WISDOM,0,1,5)*L.mana_base*2

	QUEUE_HEALTH_UPDATE(L)

/health/mob/living/adjust_loss(var/loss_type,var/value)
	. = ..()
	if(. && is_living(owner))
		var/mob/living/L = owner
		if(. > 0) //Increase damage
			L.health_regen_delay = max(L.health_regen_delay,SECONDS_TO_DECISECONDS(60))
		QUEUE_HEALTH_UPDATE(L)

/health/mob/living/adjust_mana(var/adjust_value)
	. = ..()
	if(.)
		var/mob/living/L = owner
		if(. < 0) //Reduce mana.
			L.mana_regen_delay = max(L.mana_regen_delay,SECONDS_TO_DECISECONDS(4))
		QUEUE_HEALTH_UPDATE(L)

/health/mob/living/adjust_stamina(var/adjust_value)
	. = ..()
	if(.)
		var/mob/living/L = owner
		if(stamina_current >= stamina_max*0.25 && L.has_status_effect(STAMCRIT)) L.remove_status_effect(STAMCRIT)
		if(. < 0) //Reduce stamina.
			L.stamina_regen_delay = max(L.stamina_regen_delay,SECONDS_TO_DECISECONDS(4))
		QUEUE_HEALTH_UPDATE(L)


/health/mob/living/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)

	. = 0

	var/mob/living/L = owner

	if(fatigue || mental)
		if(fatigue && (L.ai || !L.has_status_effect(STAMCRIT)))
			. += -adjust_stamina(-fatigue)
			if(stamina_current <= 0)
				if(L.has_status_effect(STAGGER))
					L.add_status_effect(STAMCRIT,-1,-1)
				else
					L.add_status_effect(STAGGER,10,10)
		if(mental)
			. += -adjust_mana(-mental)
		fatigue = 0
		mental = 0

	if(update)
		QUEUE_HEALTH_UPDATE(L)
		update = FALSE

	. += ..()

	if(sanity)
		var/sanity_loss = damage[SANITY]
		if(sanity_loss >= mana_current)
			if(!L.has_status_effect(STRESSED))
				L.add_status_effect(STRESSED,-1,1)
		else if(sanity_loss == 0)
			L.remove_status_effect(STRESSED)

	return .

/health/mob/living/get_overall_health()
	var/mob/living/L = owner
	. = health_max
	for(var/damage_type in damage)
		if(damage_type == PAIN) //Don't include pain.
			continue
		if((damage_type == TOX || damage_type == OXY) && L.has_status_effect(ADRENALINE))
			continue
		. -= damage[damage_type]

/health/mob/living/inorganic
	organic = FALSE