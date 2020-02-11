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
				health_icon_state = "dead"
			else if (L.status & FLAG_STATUS_CRIT)
				health_icon_state = "crit"
			else
				health_icon_state = "[Clamp(floor( (health_current/health_max)*23 ),0,23)]"

			L.medical_hud_image.icon_state = health_icon_state

		if(L.medical_hud_image_advanced)
			L.medical_hud_image_advanced.icon_state = "[damage[TOX] > 0][damage[BURN] > 0][damage[BRUTE] > 0]"

	return .

/health/mob/living/update_stats()

	. = ..()

	if(!is_living(owner))
		return .

	var/mob/living/L = owner

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY)*400
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_AGILITY)*400
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WILLPOWER)*400

	L.update_health_element_icons(TRUE,TRUE,TRUE,TRUE)

	return TRUE