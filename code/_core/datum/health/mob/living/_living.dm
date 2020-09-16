/health/mob/living/
	var/has_bloodloss = TRUE


/health/mob/living/get_defense(var/atom/attacker,var/atom/hit_object)

	. = ..()

	var/mob/living/advanced/A = owner

	if(A.intoxication >= 300)
		var/list/bonus_armor = list(
			BLADE = A.intoxication*0.025,
			BLUNT = A.intoxication*0.025,
			PIERCE = A.intoxication*0.025,
			ARCANE = -A.intoxication*0.025,
			HEAT = A.intoxication*0.025,
			COLD = A.intoxication*0.025,
			BOMB = A.intoxication*0.025,
		)

		for(var/damage_type in bonus_armor)
			if(.[damage_type])
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += bonus_armor[damage_type]
			else
				.[damage_type] = bonus_armor[damage_type]

	return .



/health/mob/living/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(.)

		if(!is_living(owner))
			return .

		var/mob/living/L = owner

		if(has_bloodloss)
			damage[OXY] = clamp(1 - L.blood_volume/L.blood_volume_max,0,1) * 300

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

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY)*100*L.mob_size
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_ENDURANCE)*100*L.mob_size
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WISDOM)*100*L.mob_size

	L.update_health_element_icons(TRUE,TRUE,TRUE,TRUE)

	return TRUE

/health/mob/living/adjust_fatigue_loss(var/value)

	if(!is_living(owner))
		return 0

	var/mob/living/L = owner

	if(!value)
		return 0

	if(L.has_status_effect(FATIGUE))
		return 0

	if(adjust_stamina(-value))
		L.update_health_element_icons(stamina=TRUE)

	if(stamina_current <= 0)
		L.add_status_effect(FATIGUE,value,value)

	return value

/health/mob/living/get_total_loss(var/include_fatigue = TRUE)

	if(!is_living(owner))
		return ..()

	var/mob/living/L = owner

	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		if(damage_type == TOX && L.has_status_effect(ADRENALINE))
			continue
		returning_value += damage[damage_type]

	return returning_value //min(returning_value,clamp(L.blood_volume/L.blood_volume_max,0,1)*health_max)