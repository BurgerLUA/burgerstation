/health/mob/living/advanced/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	. = 0

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner

	if(brute > 0 || burn > 0 || pain > 0 || rad > 0) //Deal damage.
		var/desired_organ = pick(TARGETABLE_LIMBS)
		if(A.labeled_organs[desired_organ])
			var/obj/item/O = A.labeled_organs[desired_organ]
			if(O.health && ((O.health.organic && organic) || (!O.health.organic && robotic)))
				. += O.health.adjust_loss_smart(
					brute = brute > 0 ? brute : 0,
					burn = burn > 0 ? burn : 0,
					pain = pain > 0 ? pain : 0,
					rad = rad > 0 ? rad : 0
				)

	if((src.organic && organic) || (!src.organic && robotic))
		if(tox) . += adjust_loss(TOX,tox)
		if(oxy) . += adjust_loss(OXY,oxy)
		if(rad) . += adjust_loss(RAD,rad)
		if(fatigue) . += adjust_loss(FATIGUE,fatigue)
		if(sanity) . += adjust_loss(SANITY,sanity)
		if(mental) . += adjust_loss(MENTAL,mental)

	if(brute < 0 || burn < 0 || pain < 0 || rad < 0) //Heal damage
		var/list/damaged_organs = list()
		var/list/damage_totals = list()
		var/list/desired_heal_amounts = list(
			BRUTE = brute < 0 ? -brute : 0,
			BURN = burn < 0 ? -burn : 0,
			PAIN = pain < 0 ? -pain : 0,
			RAD = rad < 0 ? -rad : 0
		)
		for(var/organ_id in TARGETABLE_LIMBS)
			var/obj/item/organ/O = A.labeled_organs[organ_id]
			if(!O)
				continue
			if(!O.health)
				continue
			if(O.health.organic && !organic)
				continue
			if(!O.health.organic && !robotic)
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
				PAIN = 0
			)
			for(var/damage_type in damaged_organs[organ_id])
				var/damage_amount_of_type = damaged_organs[organ_id][damage_type]
				var/heal_amount_of_type = desired_heal_amounts[damage_type]
				var/total_damage_of_type = damage_totals[damage_type]
				if( (damage_amount_of_type <= 0 || heal_amount_of_type <= 0) && total_damage_of_type != 0)
					continue
				heal_list[damage_type] = (damage_amount_of_type / total_damage_of_type) * heal_amount_of_type

			if(heal_list[BRUTE] || heal_list[BURN] || heal_list[PAIN])
				. += O.health.adjust_loss_smart(brute=-heal_list[BRUTE],burn=-heal_list[BURN],pain=-heal_list[PAIN],update=TRUE)

	if(. && update)
		A.queue_health_update = TRUE

	return .

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

	if(A.has_status_effects(STAMCRIT,SLEEP,REST))
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
	damage[RAD] = 0
	damage[PAIN] = 0

	for(var/k in A.organs)
		var/obj/item/organ/O = k
		if(!O.health)
			continue
		damage[BRUTE] += O.health.damage[BRUTE]
		damage[BURN] += O.health.damage[BURN]
		damage[RAD] += O.health.damage[RAD]
		damage[PAIN] += O.health.damage[PAIN]

	. = ..()

	if(.)
		if(health_current <= 0 && !A.status_effects[ADRENALINE] && !A.status_effects[CRIT])
			A.add_status_effect(CRIT,-1,-1,force = TRUE)

		else if( (health_current > 0 || A.status_effects[ADRENALINE]) && A.status_effects[CRIT])
			A.remove_status_effect(CRIT)

		if(damage[PAIN] > 0 && damage[PAIN] >= health_current && !A.status_effects[PAINKILLER] && !A.status_effects[PAINCRIT])
			A.add_status_effect(PAINCRIT,-1,-1,force = TRUE)

		else if((damage[PAIN] <= 0 || damage[PAIN] < health_current || A.status_effects[PAINKILLER]) && A.status_effects[PAINCRIT])
			A.remove_status_effect(PAINCRIT)

	return .


/health/mob/living/advanced/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)

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
				var/clothing_defense = C_defense_rating[damage_type]
				if(clothing_defense > 0)
					clothing_defense *= C.quality/100
				else if(clothing_defense < 0)
					clothing_defense *= max(0,2 - (C.quality/100))
				if(!ignore_luck)
					if(C.luck > 50 && prob(C.luck-50))
						clothing_defense *= 2
					else if(C.luck < 50 && prob(50-C.luck))
						clothing_defense *= 0.5
				.[damage_type] += FLOOR(clothing_defense,1)

	if((A.attack_flags & CONTROL_MOD_BLOCK) && (turn(get_dir(attacker,owner),180) & owner.dir)) //Do you even block?

		var/obj/item/item_to_block_with

		if(A.right_item && A.right_item.can_block())
			if(A.left_item && A.left_item.can_block() && A.left_item.block_defense_value > A.right_item.block_defense_value)
				item_to_block_with = A.left_item
			else
				item_to_block_with = A.right_item
		else if(A.left_item && A.left_item.can_block())
			item_to_block_with = A.left_item

		if(item_to_block_with)
			for(var/damage_type in item_to_block_with.block_defense_rating)
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += item_to_block_with.block_defense_rating[damage_type]
		else
			for(var/damage_type in ALL_DAMAGE)
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += AP_GREATSWORD*0.25 + AP_GREATSWORD*0.75*A.get_skill_power(SKILL_UNARMED)



	return .