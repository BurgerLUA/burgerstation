/health/mob/living/
	var/has_bloodoxygen = TRUE
	organic = TRUE

/health/mob/living/get_damage_multiplier()

	. = ..()

	var/mob/living/L = owner
	if(L.boss)
		var/multiplier_value = clamp(1.4 - length(L.players_fighting_boss)*0.1,0.25,1)
		. *= multiplier_value

	if(L.has_status_effect(STRESSED))
		. += 0.5

/health/mob/living/get_defense(var/atom/attacker,var/atom/hit_object,var/ignore_luck=FALSE)

	. = ..()

	var/mob/living/L = owner

	var/armor_bonus = FLOOR(L.intoxication*0.025 + max(0,L.nutrition - 1000)*0.05,5)
	var/physical_bonus = FLOOR(L.get_attribute_power(ATTRIBUTE_CONSTITUTION,0,1,2)*50,5)

	var/list/bonus_armor = list(
		BLADE = armor_bonus + physical_bonus,
		BLUNT = armor_bonus + physical_bonus,
		PIERCE = armor_bonus + physical_bonus,
		ARCANE = -armor_bonus,
		COLD = armor_bonus*2,
		PAIN = armor_bonus*2,
		FATIGUE = FLOOR(L.get_attribute_power(ATTRIBUTE_RESILIENCE,0,1,2)*100,1),
		SANITY = FLOOR(L.get_attribute_power(ATTRIBUTE_WISDOM,0,1,2)*100,1)
	)

	for(var/damage_type in bonus_armor)
		if(.[damage_type])
			if(IS_INFINITY(.[damage_type]))
				continue
			.[damage_type] += bonus_armor[damage_type]
		else
			.[damage_type] = bonus_armor[damage_type]

	for(var/list/bonus in L.defense_bonuses) //Superpowers and whatnot.
		for(var/damage_type in bonus)
			if(.[damage_type])
				if(IS_INFINITY(.[damage_type]))
					continue
				.[damage_type] += bonus[damage_type]
			else
				.[damage_type] = bonus[damage_type]

/health/mob/living/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(.)

		if(!is_living(owner)) return

		var/mob/living/L = owner

		if(has_bloodoxygen && L.blood_volume_max)
			var/blood_oxygen = (L.blood_volume/L.blood_volume_max) + L.blood_oxygen
			damage[OXY] = max(0,health_max*(2 - blood_oxygen*2))

		var/should_be_dead = check_death && L.check_death()

		if(check_death && should_be_dead)
			L.death()

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

		if(update_hud)
			L.update_health_element_icons(TRUE,TRUE,TRUE)
			L.update_boss_health()

/health/mob/living/update_health_stats()

	. = ..()

	if(!is_living(owner)) return

	var/mob/living/L = owner

	health_max = L.health_base + L.get_attribute_power(ATTRIBUTE_VITALITY,0,1,10)*min(500,L.health_base)
	stamina_max = L.stamina_base + L.get_attribute_power(ATTRIBUTE_ENDURANCE,0,1,10)*min(500,L.stamina_base)
	mana_max = L.mana_base + L.get_attribute_power(ATTRIBUTE_WISDOM,0,1,10)*min(500,L.mana_base)

	var/trait/vitality/V = L.get_trait_by_category(/trait/vitality)
	if(V)
		health_max += V.health_add
		health_max *= V.health_mul

	L.queue_health_update = TRUE

/health/mob/living/adjust_stamina(var/adjust_value)
	. = ..()
	if(. && stamina_current >= stamina_max*0.25)
		var/mob/living/L = owner
		if(L.has_status_effect(STAMCRIT)) L.remove_status_effect(STAMCRIT)

/health/mob/living/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/update=TRUE,var/organic=TRUE,var/robotic=TRUE)

	. = 0

	if(fatigue || mental)
		var/mob/living/L = owner
		var/fatigue_adjusted = FALSE
		var/mana_adjusted = FALSE
		if(fatigue && (L.ai || !L.has_status_effect(STAMCRIT)) && adjust_stamina(-fatigue))
			fatigue_adjusted = TRUE
			if(stamina_current <= 0)
				L.add_status_effect(STAMCRIT,-1,-1)
		if(mental && adjust_mana(-mental))
			mana_adjusted = TRUE
		if(fatigue_adjusted || mana_adjusted)
			L.queue_health_update = TRUE
		. += fatigue + mental
		fatigue = 0
		mental = 0

	. += ..()

	if(sanity)
		var/mob/living/L = owner
		var/sanity_loss = get_loss(SANITY)
		if(sanity_loss >= 100)
			if(!L.has_status_effect(STRESSED))
				L.add_status_effect(STRESSED,-1,1)
		else if(sanity_loss == 0)
			L.remove_status_effect(STRESSED)

	return .

/health/mob/living/get_total_loss(var/include_fatigue = TRUE,var/include_pain=TRUE,var/include_sanity=TRUE)

	if(!is_living(owner))
		return ..()

	var/mob/living/L = owner

	var/returning_value = 0
	for(var/damage_type in damage)
		if(!include_fatigue && damage_type == FATIGUE)
			continue
		if(!include_pain && damage_type == PAIN)
			continue
		if(!include_sanity && damage_type == SANITY)
			continue
		if((damage_type == TOX || damage_type == OXY) && L.has_status_effect(ADRENALINE))
			continue
		if(damage_type == PAIN)
			returning_value += max(0,damage[damage_type] - L.get_status_effect_magnitude(PAINKILLER)) //Does this even work?
		else
			returning_value += damage[damage_type]

	return returning_value

/health/mob/living/inorganic
	organic = FALSE