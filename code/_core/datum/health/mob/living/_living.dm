/health/mob/living/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	. = ..()

	if(!is_living(owner))
		return .

	var/mob/living/L = owner

	if(L.check_death())
		L.death()

	if(update_hud)
		L.update_health_element_icons(health=TRUE)
		L.update_boss_health()

	return .

/health/mob/living/update_stats()

	. = ..()

	if(!is_living(owner))
		return .

	var/mob/living/L = owner

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY)*400
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_AGILITY)*400
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WILLPOWER)*400

	L.update_health_element_icons(TRUE,TRUE,TRUE)

	return TRUE