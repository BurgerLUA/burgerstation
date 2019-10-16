/health/mob/living/advanced/adjust_brute_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(-value,0,0,0)

/health/mob/living/advanced/adjust_burn_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(0,-value,0,0)

/health/mob/living/advanced/adjust_tox_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(0,0,-value,0)

/health/mob/living/advanced/adjust_oxy_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(0,0,0,-value)

/health/mob/living/advanced/adjust_fatigue_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	if(!value)
		return 0

	if(A.fatigue_time > 0)
		return 0

	if(adjust_stamina(-value))
		A.update_health_element_icons(stamina=TRUE)

	if(stamina_current <= 0)
		A.add_fatigue(600)

	return value

health/mob/living/advanced/update_stats()

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	health_max = A.health_base + A.get_attribute_power(ATTRIBUTE_VITALITY)*400
	stamina_max = A.stamina_base + A.get_attribute_power(ATTRIBUTE_AGILITY)*400
	mana_max = A.mana_base + A.get_attribute_power(ATTRIBUTE_WILLPOWER)*400

	//Regeneration is measured in seconds
	var/recovery_skill =  A.get_skill_power(SKILL_RECOVERY)

	if(A.status & FLAG_STATUS_CRIT)
		health_regeneration = health_max * 0.01
	else
		health_regeneration = health_max * (0.002 + recovery_skill*0.005)

	stamina_regeneration = stamina_max * (0.02 + recovery_skill*0.03)
	mana_regeneration = mana_max * (0.01 + recovery_skill*0.02)

	A.update_health_element_icons(TRUE,TRUE,TRUE)


/health/mob/living/advanced/get_defense(var/atom/attacker,var/atom/hit_object)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	var/returning_value = ..()
	var/armor_level = A.get_skill_level(SKILL_ARMOR)

	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object

		for(var/obj/item/clothing/C in A.worn_objects)

			if(!C.defense_rating && length(C.defense_rating))
				continue

			if(!(O.id in C.protected_limbs))
				continue

			for(var/damage_type in C.defense_rating)
				returning_value[damage_type] += C.defense_rating[damage_type]

	for(var/k in returning_value)
		var/v = returning_value[k]
		returning_value[k] = min(v,armor_level+ARMOR_C)

	return returning_value


/health/mob/living/advanced/get_total_loss()

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	for(var/obj/item/organ/O in A.organs)
		if(!O.health)
			continue
		. += O.health.get_total_loss()

	return .

/health/mob/living/advanced/get_total_loss_soft()

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	for(var/obj/item/organ/O in A.organs)
		if(!O.health)
			continue
		. += O.health.get_total_loss_soft()

	return .