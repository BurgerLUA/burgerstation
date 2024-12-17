/health/mob/living/advanced/
	health_regeneration = 1
	mana_regeneration = 1
	stamina_regeneration = 1

/health/mob/living/advanced/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0, SANITY=0, MENTAL=0)
	var/mob/living/advanced/A = owner
	for(var/k in A.labeled_organs)
		var/obj/item/organ/O = A.labeled_organs[k]
		if(!O.health)
			continue
		O.health.restore()
	QUEUE_HEALTH_UPDATE(A)


/health/mob/living/advanced/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)

	. = 0

	var/mob/living/advanced/A = owner

	if((src.organic && organic) || (!src.organic && robotic))
		if(tox) . += adjust_loss(TOX,tox)
		if(oxy) . += adjust_loss(OXY,oxy)
		if(rad) . += adjust_loss(RAD,rad)
		if(sanity)
			. += adjust_loss(SANITY,sanity)
			var/sanity_loss = damage[SANITY]
			if(sanity_loss >= 100)
				if(!A.has_status_effect(STRESSED))
					A.add_status_effect(STRESSED,-1,-1)
			else if(sanity_loss <= 0)
				if(A.has_status_effect(STRESSED))
					A.remove_status_effect(STRESSED)
		if(fatigue && (A.ai || !A.has_status_effect(STAMCRIT)))
			. += -adjust_stamina(-fatigue)
			if(stamina_current <= 0)
				A.add_status_effect(STAMCRIT,-1,-1)
		if(mental)
			. += -adjust_mana(-mental)

	if(brute > 0 || burn > 0 || pain > 0) //Deal damage to limbs.
		var/list/limbs_to_damage = list()
		var/total_limb_mod = 0
		for(var/organ_id in TARGETABLE_LIMBS)
			var/obj/item/organ/O = A.labeled_organs[organ_id]
			if(!O || !O.health)
				continue
			if(O.health.organic && !organic)
				continue
			if(!O.health.organic && !robotic)
				continue
			limbs_to_damage += O
			total_limb_mod += O.health.health_max

		for(var/k in limbs_to_damage)
			var/obj/item/O = k
			var/limb_mod = O.health.health_max / total_limb_mod
			. += O.health.adjust_loss_smart(
				brute = brute > 0 ? brute * limb_mod : 0,
				burn = burn > 0 ? burn * limb_mod : 0,
				pain = pain > 0 ? pain * limb_mod : 0,
				organic = organic,
				robotic = robotic
			)

	if(brute < 0 || burn < 0 || pain < 0) //Heal damage to limbs.
		var/list/damaged_organs = list()
		var/list/damage_totals = list()
		var/list/desired_heal_amounts = list( //This inverses the list so its easier to work with.
			BRUTE = brute < 0 ? -brute : 0,
			BURN = burn < 0 ? -burn : 0,
			PAIN = pain < 0 ? -pain : 0
		)
		for(var/organ_id in TARGETABLE_LIMBS)
			var/obj/item/organ/O = A.labeled_organs[organ_id]
			if(!O || !O.health)
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
				if(damage_type == PAIN)
					heal_list[damage_type] = heal_amount_of_type
				else
					heal_list[damage_type] = (damage_amount_of_type / total_damage_of_type) * heal_amount_of_type

			if(heal_list[BRUTE] || heal_list[BURN] || heal_list[PAIN])
				. += O.health.adjust_loss_smart(
					brute=-heal_list[BRUTE],
					burn=-heal_list[BURN],
					pain=-heal_list[PAIN],
					organic=organic,
					robotic=robotic
				)

	if(update)
		QUEUE_HEALTH_UPDATE(A)
		update = FALSE

	return .

/health/mob/living/advanced/update_health_stats()

	. = ..()

	var/mob/living/advanced/A = owner

	if(is_player(A))
		var/mob/living/advanced/player/P = A

		var/actual_difficulty = P.get_difficulty()

		if(actual_difficulty == DIFFICULTY_EXTREME || actual_difficulty == DIFFICULTY_NIGHTMARE)
			health_regeneration = 0
		else
			health_regeneration = initial(health_regeneration)

		if(actual_difficulty == DIFFICULTY_NIGHTMARE)
			stamina_regen_cooef = 0.5
			mana_regen_cooef = 0.5
		else
			stamina_regen_cooef = initial(stamina_regen_cooef)
			mana_regen_cooef = initial(mana_regen_cooef)

	if(health_regeneration > 0)
		if(health_current <= 0) //In crit.
			health_regeneration = 2 + (A.get_attribute_power(ATTRIBUTE_FORTITUDE,0,1,5)*18)
		else
			health_regeneration = 1 + (A.get_attribute_power(ATTRIBUTE_FORTITUDE,0,1,5)*9)

	if(stamina_regeneration > 0)
		if(A.has_status_effects(STAMCRIT,SLEEP,REST,ADRENALINE))
			stamina_regeneration = 20 + (A.get_attribute_power(ATTRIBUTE_RESILIENCE,0,1,5)*30)
		else
			stamina_regeneration = 10 + (A.get_attribute_power(ATTRIBUTE_RESILIENCE,0,1,5)*20)

	if(mana_regeneration > 0)
		mana_regeneration = 10 + (A.get_attribute_power(ATTRIBUTE_WILLPOWER,0,1,5)*20)

	for(var/k in A.labeled_organs)
		var/obj/item/organ/O = A.labeled_organs[k]
		if(!O.health)
			continue
		O.health.update_health_stats()



/health/mob/living/advanced/update_health()

	//Some damage is reset and defered to organs.
	var/mob/living/advanced/A = owner
	damage[BRUTE] = 0
	damage[BURN] = 0
	damage[RAD] = 0
	damage[PAIN] = 0

	for(var/k in A.organs)
		var/obj/item/organ/O = k
		if(!O.health)
			continue
		if(O.damage_coefficient <= 0)
			continue
		damage[BRUTE] += O.health.damage[BRUTE] * O.damage_coefficient
		damage[BURN] += O.health.damage[BURN] * O.damage_coefficient
		damage[RAD] += O.health.damage[RAD] * O.damage_coefficient
		damage[PAIN] += O.health.damage[PAIN] * O.damage_coefficient

	. = ..()

/health/mob/living/advanced/get_overall_health()

	var/mob/living/advanced/A = owner

	. = ..()
	if(A.is_player_controlled() && A.has_status_effect(CRITPROTECTION))
		. = max(0,.)

/health/mob/living/advanced/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)

	. = ..()

	if(!is_organ(hit_object))
		return .

	var/mob/living/advanced/A = owner
	var/obj/item/organ/O = hit_object
	var/armor/ARM_O = ARMOR(O.armor)
	if(ARM_O)
		.["deflection"] = max(.["deflection"],ARM_O.deflection)
		for(var/damage_type in ARM_O.defense_rating)
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(ARM_O.defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
				.[damage_type] = ARM_O.defense_rating[damage_type]
				continue
			.[damage_type] += ARM_O.defense_rating[damage_type]

	var/armor_multiplier = 1 + A.get_skill_power(SKILL_ARMOR,0,1,2)
	.["items"] = list()
	for(var/k in A.worn_objects)
		var/obj/item/clothing/C = k
		if(!is_clothing(C))
			continue
		if(!(O.id in C.protected_limbs))
			continue
		var/armor/ARM_C = ARMOR(C.armor)
		if(!ARM_C)
			continue
		.["deflection"] = max(.["deflection"],ARM_C.deflection)
		for(var/damage_type in ARM_C.defense_rating)
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(ARM_C.defense_rating[damage_type])) //If the clothing's defense is infinity, set it to infinity.
				.[damage_type] = ARM_C.defense_rating[damage_type]
				continue
			var/clothing_defense = ARM_C.defense_rating[damage_type] * armor_multiplier
			if(clothing_defense > 0)
				clothing_defense *= C.get_quality_mod()
				if(!ignore_luck)
					if(C.luck > 50 && prob(C.luck-50))
						clothing_defense *= 2
					else if(C.luck < 50 && prob(50-C.luck))
						clothing_defense *= 0.5
			.[damage_type] += FLOOR(clothing_defense,1)
		.["items"] += C

	var/mana_armor_value = STATUS_EFFECT_MAGNITUDE(A,MANA_ARMOR)
	if(mana_armor_value > 0 && mana_current >= mana_max*0.5 && length(A.overall_clothing_defense_rating) && A.overall_clothing_defense_rating[ARCANE] > 0)
		var/bonus_mana_armor = (mana_armor_value/100) * A.overall_clothing_defense_rating[ARCANE]
		bonus_mana_armor = CEILING(bonus_mana_armor,1)
		if(bonus_mana_armor > 0)
			for(var/damage_type in list(BLADE,BLUNT,PIERCE))
				if(!.[damage_type])
					.[damage_type] = 0
				else if(IS_INFINITY(.[damage_type]))
					continue
				var/damage_type_difference = min(bonus_mana_armor,bonus_mana_armor - .[damage_type])
				if(damage_type_difference > 0)
					.[damage_type] += damage_type_difference








