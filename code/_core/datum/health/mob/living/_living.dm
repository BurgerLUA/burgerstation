/health/mob/living/
	var/has_bloodoxygen = TRUE
	organic = TRUE

/health/mob/living/get_damage_multiplier()

	. = ..()

	var/mob/living/L = owner
	if(L.boss)
		var/multiplier_value = clamp(1.4 - length(L.players_fighting_boss)*0.1,0.25,1)
		. *= multiplier_value

	return .

/health/mob/living/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)

	. = ..()

	var/mob/living/L = owner

	var/armor_bonus = FLOOR(L.intoxication*0.025 + max(0,L.nutrition - 1000)*0.05,5)

	var/list/bonus_armor = list(
		BLADE = armor_bonus,
		BLUNT = armor_bonus,
		PIERCE = armor_bonus,
		ARCANE = -armor_bonus,
		COLD = armor_bonus*2,
		PAIN = armor_bonus*2,
		FATIGUE = FLOOR(L.get_attribute_power(ATTRIBUTE_RESILIENCE)*100,1),
		SANITY = FLOOR(L.get_attribute_power(ATTRIBUTE_WISDOM)*100,1)
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

	return .



/health/mob/living/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(.)

		if(!is_living(owner))
			return .

		var/mob/living/L = owner

		if(has_bloodoxygen && L.blood_volume_max)
			var/blood_oxygen = (L.blood_volume/L.blood_volume_max) + L.blood_oxygen
			damage[OXY] = max(0,health_max*(2 - blood_oxygen*2))

		var/should_be_dead = check_death && L.check_death()

		if(check_death && should_be_dead)
			L.death()

		if(update_hud)
			L.update_health_element_icons(TRUE,TRUE,TRUE,TRUE)
			L.update_boss_health()

		if(L.medical_hud_image)
			var/health_icon_state
			if(L.dead)
				if(L.is_player_controlled() && !L.suicide)
					if(should_be_dead)
						health_icon_state = "revive_2"
					else
						health_icon_state = "revive_3"
				else
					health_icon_state = "dead"
			else if (L.has_status_effect(CRIT))
				health_icon_state = "crit"
			else
				health_icon_state = "[clamp(FLOOR((health_current/health_max)*23, 1),0,23)]"

			L.medical_hud_image.icon_state = health_icon_state

		if(L.medical_hud_image_advanced)
			L.medical_hud_image_advanced.icon_state = "[damage[TOX] > 0][damage[BURN] > 0][damage[BRUTE] > 0]"

	return .

/health/mob/living/update_health_stats()

	. = ..()

	if(!is_living(owner))
		return .

	var/mob/living/L = owner

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY)*100
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_ENDURANCE)*100
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WISDOM)*100

	L.queue_health_update = TRUE

	return TRUE


/health/mob/living/adjust_stamina(var/adjust_value)
	. = ..()
	if(. && stamina_current >= stamina_max)
		var/mob/living/L = owner
		if(L.has_status_effect(STAMCRIT)) L.remove_status_effect(STAMCRIT)
	return .


/health/mob/living/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	. = 0

	if(fatigue || mental)
		var/mob/living/L = owner
		var/fatigue_adjusted = FALSE
		var/mana_adjusted = FALSE
		if(fatigue && (L.ai || !L.has_status_effect(STAMCRIT)) && adjust_stamina(-fatigue))
			fatigue_adjusted = TRUE
			if(stamina_current <= 0)
				L.add_status_effect(STAMCRIT,-1,-1)
		if(mental && adjust_mana(-mental))
			mana_adjusted = TRUE
		if(fatigue_adjusted || mana_adjusted)
			L.queue_health_update = TRUE
		fatigue = 0
		mental = 0

	return . + ..()

/health/mob/living/get_total_loss(var/include_fatigue = TRUE,var/include_pain=TRUE,var/include_sanity=TRUE)

	if(!is_living(owner))
		return ..()

	var/mob/living/L = owner

	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		if(!include_pain && damage_type == PAIN)
			continue
		if(!include_sanity && damage_type == SANITY)
			continue
		if((damage_type == TOX || damage_type == OXY) && L.has_status_effect(ADRENALINE))
			continue
		returning_value += damage[damage_type]

	return returning_value //min(returning_value,clamp(L.blood_volume/L.blood_volume_max,0,1)*health_max)