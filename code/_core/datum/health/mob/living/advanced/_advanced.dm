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
		A.queue_health_update = TRUE

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

/health/mob/living/advanced/update_health_stats()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(health_current <= 0) //In crit.
		health_regeneration = (2 + A.get_attribute_power(ATTRIBUTE_FORTITUDE)*19)
	else
		health_regeneration = (1 + A.get_attribute_power(ATTRIBUTE_FORTITUDE)*9)

	if(A.has_status_effects(FATIGUE,SLEEP,REST))
		stamina_regeneration = (3 + A.get_attribute_power(ATTRIBUTE_RESILIENCE)*29)
	else
		stamina_regeneration = (2 + A.get_attribute_power(ATTRIBUTE_RESILIENCE)*19)

	mana_regeneration = (2 + A.get_attribute_power(ATTRIBUTE_WILLPOWER)*19)

	return ..()


/health/mob/living/advanced/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	damage[BRUTE] = 0
	damage[BURN] = 0
	for(var/k in A.organs)
		var/obj/item/organ/O = k
		if(!O.health)
			continue
		damage[BRUTE] += O.health.damage[BRUTE]
		damage[BURN] += O.health.damage[BURN]

	. = ..()

	if(.)
		if(health_current <= 0 && !A.status_effects[ADRENALINE] && !A.status_effects[CRIT])
			A.add_status_effect(CRIT,-1,-1,force = TRUE)

		else if( (health_current > 0 || A.status_effects[ADRENALINE]) && A.status_effects[CRIT])
			A.remove_status_effect(CRIT)

	return .


/health/mob/living/advanced/get_defense(var/atom/attacker,var/atom/hit_object)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	. = ..()

	if(is_organ(hit_object))
		var/obj/item/organ/O = hit_object
		var/list/O_defense_rating = O.get_defense_rating()
		for(var/damage_type in O_defense_rating)
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(O_defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
				.[damage_type] = O_defense_rating[damage_type]
				continue
			.[damage_type] += O_defense_rating[damage_type]

		for(var/obj/item/clothing/C in A.worn_objects)
			if(!(O.id in C.protected_limbs))
				continue
			var/list/C_defense_rating = C.get_defense_rating()
			for(var/damage_type in C_defense_rating)
				if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
					continue
				if(IS_INFINITY(C_defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
					.[damage_type] = C_defense_rating[damage_type]
					continue
				.[damage_type] += C_defense_rating[damage_type]

	if((A.attack_flags & ATTACK_HOLD) && (get_dir(attacker,owner) != owner.dir)) //Do you even block?
		for(var/damage_type in ALL_DAMAGE)
			if(IS_INFINITY(.[damage_type]))
				continue
			.[damage_type] += 25 //25 extra armor when blocking regardless of item.

		if(A.right_item && A.right_item.can_block() && length(A.right_item.block_defense_rating))
			for(var/damage_type in A.right_item.block_defense_rating)
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += A.right_item.block_defense_rating[damage_type]

		if(A.left_item && A.left_item.can_block() && length(A.left_item.block_defense_rating))
			for(var/damage_type in A.left_item.block_defense_rating)
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += A.left_item.block_defense_rating[damage_type]

	return .