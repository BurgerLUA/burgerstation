//Skills
/mob/living/proc/get_skill(id,error_on_null = TRUE)
	if(!skills[id])
		if(error_on_null) log_error("Warning! Tried getting skill of [id], but it didn't exist for [src.get_debug_name()]!")
		return null
	return skills[id]

/mob/living/proc/get_skill_level(id)
	var/experience/skill/S = get_skill(id)
	if(!S)
		log_error("Warning! Tried getting skill level of [id], but it didn't exist for [src.get_debug_name()]!")
		return 25
	return S.get_current_level()

/mob/living/proc/get_skill_power(id,min_power=0.25,max_power=1,absolute_max_power)
	var/experience/skill/S = get_skill(id)
	if(!S)
		log_error("Warning! Tried getting skill power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25
	return S.get_power(min_power,max_power,absolute_max_power)

/mob/living/proc/set_skill_level(id,desired_level)
	var/experience/skill/S = get_skill(id)
	return S.set_level(desired_level)

/mob/living/proc/set_skill_xp(id,desired_xp)
	var/experience/skill/S = get_skill(id)
	return S.set_xp(desired_xp)

/mob/living/proc/add_skill_xp(id,xp_to_add,difficulty_multiplier=TRUE)
	var/experience/skill/S = get_skill(id)
	return S.add_xp(xp_to_add,difficulty_multiplier=difficulty_multiplier)

//Attributes
/mob/living/proc/get_attribute(id,error_on_null = TRUE) //TODO: Find out if error_on_null is needed.
	if(!attributes[id])
		if(error_on_null) log_error("Warning! Tried getting attribute of [id], but it didn't exist for [src.get_debug_name()]!")
		return null
	return attributes[id]

/mob/living/proc/get_attribute_level(id)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		log_error("Warning! Tried getting attribute level of [id], but it didn't exist for [src.get_debug_name()]!")
		return 25
	return A.get_current_level()

/mob/living/proc/get_attribute_power(id,min_power=0.25,max_power=1,absolute_max_power)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		log_error("Warning! Tried getting attribute power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25
	return A.get_power(min_power,max_power,absolute_max_power)

/mob/living/proc/set_attribute_level(id,desired_level)
	var/experience/attribute/A = get_attribute(id)
	return A.set_level(desired_level)

/mob/living/proc/set_attribute_xp(id,desired_xp)
	var/experience/attribute/A = get_attribute(id)
	return A.set_xp(desired_xp)

/mob/living/proc/add_attribute_xp(id,xp_to_add,difficulty_multiplier=TRUE)
	var/experience/attribute/A = get_attribute(id)
	return A.add_xp(xp_to_add,difficulty_multiplier=difficulty_multiplier)

/mob/living/get_xp_multiplier()
	if(master)
		return 0
	return 1

/mob/living/proc/initialize_attributes()

	var/class/C = SSclass.all_classes[class]

	if(!C) C = SSclass.all_classes[/class/]

	var/attribute_amount = length(SSexperience.all_attributes)*0.5
	for(var/k in SSexperience.all_attributes) //k is the id
		var/v = SSexperience.all_attributes[k]
		var/experience/attribute/E = new v(src)
		if(C.weights_attribute[E.id])
			var/weight_mod = attribute_amount*level*(C.weights_attribute[E.id]/C.total_attribute_weight)
			E.update_experience(E.level_to_xp(CEILING(weight_mod,1)))
		else
			E.update_experience(E.level_to_xp(E.default_level))
		attributes[E.id] = E

/mob/living/proc/initialize_skills()

	var/class/C = SSclass.all_classes[class]

	if(!C) C = SSclass.all_classes[/class/]

	var/skills_amount = length(SSexperience.all_skills)*0.5
	for(var/k in SSexperience.all_skills) //k is the id
		var/v = SSexperience.all_skills[k]
		var/experience/skill/E = new v(src)
		if(C.weights_skill[E.id])
			var/weight_mod = skills_amount*level*(C.weights_skill[E.id]/C.total_skill_weight)
			E.update_experience(E.level_to_xp(CEILING(weight_mod,1)))
		else
			E.update_experience(E.level_to_xp(E.default_level))
		skills[E.id] = E

/mob/living/proc/update_level(first=FALSE)

	var/old_level = level

	var/total_score = 0
	var/max_score = 0

	for(var/k in attributes)
		var/experience/attribute/A = attributes[k]
		if(!A.counts_towards_level)
			continue
		total_score += A.get_current_level()
		max_score += 100

	for(var/k in skills)
		var/experience/skill/S = skills[k]
		if(!S.counts_towards_level)
			continue
		total_score += S.get_current_level()
		max_score += 100

	if(!total_score)
		CRASH("ERROR: FOUND [total_score] VALID ATTRIBUTES/SKILLS.")

	// https://www.desmos.com/calculator/cka4qx8qr0
	level = max(1,CEILING( (total_score/max_score)*(100),1))

	if(ai && health)
		level += CEILING(health.health_max/100,1) - 1

	if(!first && old_level != level)
		var/decrease = old_level > level
		if(decrease)
			to_chat(span("warning","Your overall level decreased to [level]..."))
		else
			to_chat(span("notice","Your overall level increased to [level]!"))

	return old_level != level


/mob/living/proc/on_add_xp(experience/E,added_xp)
	return TRUE

/mob/living/proc/on_level_up(experience/E,old_level,new_level)

	var/decrease = old_level > new_level

	if(decrease)
		to_chat(span("warning","Your [E.name] decreased from [old_level] to [new_level]..."))
	else
		to_chat(span("notice","Your [E.name] increased from [old_level] to [new_level]!"))

	if(new_level > old_level) //Only care if it's an increase.
		switch(E.id)
			if(ATTRIBUTE_STRENGTH,ATTRIBUTE_FORTITUDE,ATTRIBUTE_CONSTITUTION)
				add_attribute_xp(ATTRIBUTE_VITALITY,new_level-old_level,FALSE)
			if(ATTRIBUTE_DEXTERITY,ATTRIBUTE_RESILIENCE,ATTRIBUTE_AGILITY)
				add_attribute_xp(ATTRIBUTE_ENDURANCE,new_level-old_level,FALSE)
			if(ATTRIBUTE_INTELLIGENCE,ATTRIBUTE_WILLPOWER,ATTRIBUTE_SOUL)
				add_attribute_xp(ATTRIBUTE_WISDOM,new_level-old_level,FALSE)

	update_level()

	return TRUE
