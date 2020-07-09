/health/mob/living/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(.)

		if(!is_living(owner))
			return .

		var/mob/living/L = owner

		if(L.check_death())
			L.death()

		if(update_hud)
			L.update_health_element_icons(health=TRUE,update_body=TRUE)
			L.update_boss_health()

		if(L.medical_hud_image)
			var/health_icon_state
			if(L.dead)
				if(L.client && !L.suicide)
					health_icon_state = "revive"
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

	return returning_value