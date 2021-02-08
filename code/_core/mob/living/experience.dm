//Skills
/mob/living/proc/get_skill(var/id,var/error_on_null = TRUE)
	if(!skills[id])
		if(error_on_null) CRASH_SAFE("Warning! Tried getting skill of [id], but it didn't exist for [src.get_debug_name()]!")
		return null
	return skills[id]

/mob/living/proc/get_skill_level(var/id)
	var/experience/skill/S = get_skill(id)
	if(!S)
		CRASH_SAFE("Warning! Tried getting skill level of [id], but it didn't exist for [src.get_debug_name()]!")
		return 25
	return S.get_current_level()

/mob/living/proc/get_skill_power(var/id)
	var/experience/skill/S = get_skill(id)
	if(!S)
		CRASH_SAFE("Warning! Tried getting skill power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25
	return S.get_power()

/mob/living/proc/set_skill_level(var/id,var/desired_level)
	var/experience/skill/S = get_skill(id)
	return S.set_level(desired_level)

/mob/living/proc/set_skill_xp(var/id,var/desired_xp)
	var/experience/skill/S = get_skill(id)
	return S.set_xp(desired_xp)

/mob/living/proc/add_skill_xp(var/id,var/xp_to_add)
	var/experience/skill/S = get_skill(id)
	return S.add_xp(xp_to_add)

//Attributes
/mob/living/proc/get_attribute(var/id,var/error_on_null = TRUE)
	if(!attributes[id])
		if(error_on_null) CRASH_SAFE("Warning! Tried getting attribute of [id], but it didn't exist for [src.get_debug_name()]!")
		return null
	return attributes[id]

/mob/living/proc/get_attribute_level(var/id)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		CRASH_SAFE("Warning! Tried getting attribute level of [id], but it didn't exist for [src.get_debug_name()]!")
		return 25
	return A.get_current_level()

/mob/living/proc/get_attribute_power(var/id)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		CRASH_SAFE("Warning! Tried getting attribute power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25
	return A.get_power()

/mob/living/proc/set_attribute_level(var/id,var/desired_level)
	var/experience/attribute/A = get_attribute(id)
	return A.set_level(desired_level)

/mob/living/proc/set_attribute_xp(var/id,var/desired_xp)
	var/experience/attribute/A = get_attribute(id)
	return A.set_xp(desired_xp)

/mob/living/proc/add_attribute_xp(var/id,var/xp_to_add)
	var/experience/attribute/A = get_attribute(id)
	return A.add_xp(xp_to_add)

/mob/living/get_xp_multiplier()
	return 1

/mob/living/proc/initialize_attributes()

	var/class/C = all_classes[class]

	for(var/k in SSexperience.all_attributes)
		var/v = SSexperience.all_attributes[k]
		var/experience/attribute/A = new v(src)
		var/desired_level = C.attributes[A.id]
		if(k == ATTRIBUTE_LUCK)
			A.update_experience(A.level_to_xp(desired_level))
		else
			A.update_experience(A.level_to_xp(desired_level*level_multiplier))
		attributes[A.id] = A

/mob/living/proc/initialize_skills()

	var/class/C = all_classes[class]

	for(var/k in SSexperience.all_skills)
		var/v = SSexperience.all_skills[k]
		var/experience/skill/S = new v(src)
		var/desired_level = C.skills[S.id]
		S.update_experience(S.level_to_xp(clamp(desired_level*level_multiplier,1,100)))
		skills[S.id] = S

/mob/living/proc/update_level(var/first=FALSE)

	var/total_attribute_mod = 0
	var/total_skill_mod = 0

	var/total_attributes = 0
	var/total_skills = 0

	for(var/k in attributes)
		var/experience/attribute/A = attributes[k]
		if(A.counts_towards_level)
			total_attribute_mod += ((A.get_current_level() - A.default_level)/src.max_level)*A.combat_level_mul
			total_attributes += 1

	for(var/k in skills)
		var/experience/skill/S = skills[k]
		if(S.counts_towards_level)
			total_skill_mod += ((S.get_current_level() - S.default_level)/src.max_level)*S.combat_level_mul
			total_skills += 1

	if(!total_skills || !total_attributes)
		log_error("ERROR: FOUND [total_skills] SKILLS AND [total_attributes] ATTRIBUTES.")
		return FALSE

	total_attribute_mod = total_attribute_mod/total_attributes
	total_skill_mod = total_skill_mod/total_skills

	var/old_level = level

	level = clamp(FLOOR(1 + (total_attribute_mod*0.75 + total_skill_mod*0.25)*(LEVEL_CAP-1), 1),1,200)

	if(!first && old_level != level)
		var/decrease = old_level > level
		if(decrease)
			to_chat(span("warning","Your overall level decreased to [level]..."))
		else
			to_chat(span("notice","Your overall level increased to [level]!"))

	return old_level != level


/mob/living/proc/on_add_xp(var/experience/E,var/added_xp)
	return TRUE

/mob/living/proc/on_level_up(var/experience/E,var/old_level,var/new_level)

	var/decrease = old_level > new_level

	if(decrease)
		to_chat(span("warning","Your [E.name] decreased from [old_level] to [new_level]..."))
	else
		to_chat(span("notice","Your [E.name] increased from [old_level] to [new_level]!"))

	if(new_level > old_level) //Only care if it's an increase.
		switch(E.id)
			if(ATTRIBUTE_STRENGTH,ATTRIBUTE_FORTITUDE)
				add_attribute_xp(ATTRIBUTE_VITALITY,new_level-old_level)
			if(ATTRIBUTE_DEXTERITY,ATTRIBUTE_RESILIENCE)
				add_attribute_xp(ATTRIBUTE_ENDURANCE,new_level-old_level)
			if(ATTRIBUTE_INTELLIGENCE,ATTRIBUTE_WILLPOWER)
				add_attribute_xp(ATTRIBUTE_WISDOM,new_level-old_level)

	update_level()

	return TRUE
