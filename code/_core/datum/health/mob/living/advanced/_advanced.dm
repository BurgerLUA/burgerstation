/health/mob/living/advanced/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/update=TRUE)

	var/total_damage = 0

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(brute > 0 || burn > 0) //Deal damage.
		var/desired_organ = pick(TARGETABLE_LIMBS)
		if(A.labeled_organs[desired_organ])
			var/obj/item/O = A.labeled_organs[desired_organ]
			if(O.health)
				total_damage = O.health.adjust_loss_smart(brute=brute > 0 ? brute : 0,burn=burn > 0 ? burn : 0)

	if(tox)
		tox -= (tox > 0 ? resistance[TOX] : 0)
		tox -= min(0,damage[TOX] + tox)
		damage[TOX] += tox
		total_damage += tox

	if(oxy)
		oxy -= (oxy > 0 ? resistance[OXY] : 0)
		oxy -= min(0,damage[OXY] + oxy)
		damage[OXY] += oxy
		total_damage += oxy

	if(brute < 0 || burn < 0) //Heal damage
		var/list/desired_heal_amounts = list(
			BRUTE = brute < 0 ? -brute : 0,
			BURN = burn < 0 ? -burn : 0,
		) //Tox, Fatigue, and Oxy not included here.

		var/list/damaged_organs = list()

		var/list/damage_totals = list()

		for(var/organ_id in A.labeled_organs)
			var/obj/item/organ/O = A.labeled_organs[organ_id]
			if(!O.health)
				continue
			for(var/damage_type in O.health.damage)
				var/damage_amount =  O.health.damage[damage_type]
				if(!damage_amount || damage_amount < 0)
					continue
				if(!damaged_organs[organ_id])
					damaged_organs[organ_id] = list()
				damaged_organs[organ_id][damage_type] += damage_amount
				damage_totals[damage_type] += damage_amount

		for(var/organ_id in damaged_organs)
			var/obj/item/organ/O = A.labeled_organs[organ_id]
			if(!O.health)
				continue
			var/list/heal_list = list(
				BRUTE = 0,
				BURN = 0,
				TOX = 0,
				OXY = 0
			)
			for(var/damage_type in damaged_organs[organ_id])
				var/damage_amount_of_type = damaged_organs[organ_id][damage_type]
				var/heal_amount_of_type = desired_heal_amounts[damage_type]
				var/total_damage_of_type = damage_totals[damage_type]
				if( (damage_amount_of_type <= 0 || heal_amount_of_type <= 0) && total_damage_of_type != 0)
					continue
				heal_list[damage_type] = (damage_amount_of_type / total_damage_of_type) * heal_amount_of_type

			if(heal_list[BRUTE] || heal_list[BURN] || heal_list[TOX] || heal_list[OXY])
				total_damage += O.health.adjust_loss_smart(brute=-heal_list[BRUTE],burn=-heal_list[BURN],tox=-heal_list[TOX],oxy=-heal_list[OXY],update=FALSE)

	if(total_damage && update)
		update_health(total_damage)

	return total_damage

/health/mob/living/advanced/adjust_brute_loss(var/value)
	return owner.health.adjust_loss_smart(brute=value)

/health/mob/living/advanced/adjust_burn_loss(var/value)
	return owner.health.adjust_loss_smart(burn=value)


/*
/health/mob/living/advanced/adjust_tox_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(0,0,-value,0)
*/

/*
/health/mob/living/advanced/adjust_oxy_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	return A.heal_all_organs(0,0,0,-value)
*/

/health/mob/living/advanced/adjust_fatigue_loss(var/value)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	if(!value)
		return 0

	if(A.has_status_effect(FATIGUE))
		return 0

	if(adjust_stamina(-value))
		A.update_health_element_icons(stamina=TRUE)

	if(stamina_current <= 0)
		A.add_status_effect(FATIGUE,value,value)

	return value

health/mob/living/advanced/update_health_stats()

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	var/endurance = A.get_attribute_power(ATTRIBUTE_ENDURANCE) //Endurance is used twice here.

	health_max = A.health_base + A.get_attribute_power(ATTRIBUTE_VITALITY)*400
	stamina_max = A.stamina_base + endurance*400
	mana_max = A.mana_base + A.get_attribute_power(ATTRIBUTE_WISDOM)*400

	if(health_current <= 0)
		health_regeneration = health_max * (0.01 + A.get_attribute_power(ATTRIBUTE_FORTITUDE)*0.025)
	else
		health_regeneration = health_max * (0.002 + A.get_attribute_power(ATTRIBUTE_FORTITUDE)*0.005)

	if(A.has_status_effect(list(FATIGUE,SLEEP)))
		stamina_regeneration = stamina_max * (0.1 + endurance*0.15)
	else
		stamina_regeneration = stamina_max * (0.02 + endurance*0.03)

	if(A.has_status_effect(SLEEP))
		mana_regeneration = mana_max * (0.05 + A.get_attribute_power(ATTRIBUTE_WILLPOWER)*0.1)
	else
		mana_regeneration = mana_max * (0.01 + A.get_attribute_power(ATTRIBUTE_WILLPOWER)*0.02)

	A.update_health_element_icons(TRUE,TRUE,TRUE,TRUE)


/health/mob/living/advanced/update_health(var/damage_dealt,var/atom/attacker,var/update_hud=TRUE)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	damage[BRUTE] = 0
	damage[BURN] = 0
	for(var/obj/item/organ/O in A.organs)
		if(!O.health)
			continue
		damage[BRUTE] += O.health.damage[BRUTE]
		damage[BURN] += O.health.damage[BURN]

	. = ..()

	if(.)
		if(health_current <= 0 && !A.status_effects[CRIT])
			A.add_status_effect(CRIT,-1,-1,force = TRUE)

		else if(health_current > 0 && A.status_effects[CRIT])
			A.remove_status_effect(CRIT)

	return .


/health/mob/living/advanced/get_defense(var/atom/attacker,var/atom/hit_object)

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	var/list/returning_value = ..()

	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object

		for(var/obj/item/clothing/C in A.worn_objects)

			if(!C.defense_rating && length(C.defense_rating))
				continue

			if(!(O.id in C.protected_limbs))
				continue

			for(var/damage_type in C.defense_rating)
				returning_value[damage_type] += C.defense_rating[damage_type]

	return returning_value


/*
/health/mob/living/advanced/get_total_loss()

	if(!is_advanced(owner))
		return 0

	var/mob/living/advanced/A = owner

	for(var/obj/item/organ/O in A.organs)
		if(!O.health)
			continue
		. += O.health.get_total_loss()

	return .
*/