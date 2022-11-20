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

	if(brute > 0 || burn > 0 || pain > 0 || rad > 0) //Deal damage.
		var/desired_organ = pick(TARGETABLE_LIMBS)
		if(A.labeled_organs[desired_organ])
			var/obj/item/O = A.labeled_organs[desired_organ]
			if(O.health && ((O.health.organic && organic) || (!O.health.organic && robotic)))
				. += O.health.adjust_loss_smart(
					brute = brute > 0 ? brute : 0,
					burn = burn > 0 ? burn : 0,
					pain = pain > 0 ? pain : 0,
					rad = rad > 0 ? rad : 0,
					organic = organic,
					robotic = robotic,
					update = FALSE
				)

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

	mental = 0
	fatigue = 0

	if(brute < 0 || burn < 0 || pain < 0 || rad < 0) //Heal damage
		var/list/damaged_organs = list()
		var/list/damage_totals = list()
		var/list/desired_heal_amounts = list( //This inverses the list so its easier to work with.
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
				PAIN = 0,
				RAD = 0
			)
			for(var/damage_type in damaged_organs[organ_id])
				var/damage_amount_of_type = damaged_organs[organ_id][damage_type]
				var/heal_amount_of_type = desired_heal_amounts[damage_type]
				var/total_damage_of_type = damage_totals[damage_type]
				if( (damage_amount_of_type <= 0 || heal_amount_of_type <= 0) && total_damage_of_type != 0)
					continue
				heal_list[damage_type] = (damage_amount_of_type / total_damage_of_type) * heal_amount_of_type

			if(heal_list[BRUTE] || heal_list[BURN] || heal_list[PAIN])
				. += O.health.adjust_loss_smart(brute=-heal_list[BRUTE],burn=-heal_list[BURN],pain=-heal_list[PAIN],organic=organic,robotic=robotic)

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
		if(A.has_status_effects(STAMCRIT,SLEEP,REST))
			stamina_regeneration = 20 + (A.get_attribute_power(ATTRIBUTE_RESILIENCE,0,1,5)*30)
		else
			stamina_regeneration = 10 + (A.get_attribute_power(ATTRIBUTE_RESILIENCE,0,1,5)*20)

	if(mana_regeneration > 0)
		mana_regeneration = 10 + (A.get_attribute_power(ATTRIBUTE_WILLPOWER,0,1,5)*20)




/health/mob/living/advanced/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	//Advanced damage is reset and defered to organs.
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
		damage[PAIN] += max(0, (O.health.damage[PAIN] * O.damage_coefficient) - A.pain_removal)

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

	.["items"] = list()
	for(var/obj/item/clothing/C in A.worn_objects)
		if(!(O.id in C.protected_limbs))
			continue
		var/armor/ARM_C = ARMOR(C.armor)
		if(!ARM_C)
			continue
		.["deflection"] = max(.["deflection"],ARM_C.deflection)
		for(var/damage_type in ARM_C.defense_rating)
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(ARM_C.defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
				.[damage_type] = ARM_C.defense_rating[damage_type]
				continue
			var/clothing_defense = ARM_C.defense_rating[damage_type]
			if(!ignore_luck)
				if(C.luck > 50 && prob(C.luck-50))
					clothing_defense *= 2
				else if(C.luck < 50 && prob(50-C.luck))
					clothing_defense *= 0.5
			.[damage_type] += FLOOR(clothing_defense,1)
		.["items"] += C
/health/mob/living/advanced/proc/get_total_mob_defense(var/arcane_only=FALSE,var/ignore_luck = FALSE) //Checks total armor of all clothes combined. Probably shouldnt call much.
	. = list()
	var/mob/living/advanced/A = owner
	for(var/obj/item/clothing/C in A.worn_objects)
		var/armor/ARM_C = ARMOR(C.armor)
		if(!ARM_C)
			continue
		.["deflection"] = max(.["deflection"],ARM_C.deflection)
		for(var/damage_type in ARM_C.defense_rating)
			if(arcane_only && !(damage_type == ARCANE || damage_type == HOLY || damage_type == DARK))
				continue
			if(IS_INFINITY(.[damage_type])) //If our defense is already infinity, then forget about it.
				continue
			if(IS_INFINITY(ARM_C.defense_rating[damage_type])) //If the organ's defense is infinity, set it to infinity.
				.[damage_type] += ARM_C.defense_rating[damage_type]
				continue
			var/clothing_defense = ARM_C.defense_rating[damage_type]
			if(!ignore_luck)
				if(C.luck > 50 && prob(C.luck-50))
					clothing_defense *= 2
				else if(C.luck < 50 && prob(50-C.luck))
					clothing_defense *= 0.5
			.[damage_type] += FLOOR(clothing_defense,1)
