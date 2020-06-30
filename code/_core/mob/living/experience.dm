/mob/living/get_xp_multiplier()
	return ai ? 1 : 0

/mob/living/proc/initialize_attributes()

	var/class/C = all_classes[class]

	for(var/k in SSexperience.all_attributes)
		var/v = SSexperience.all_attributes[k]
		var/experience/attribute/A = new v(src)
		var/desired_level = C.attributes[A.id]
		A.Initialize(A.level_to_xp(clamp(desired_level*level_multiplier,1,100)))
		attributes[A.id] = A

/mob/living/proc/initialize_skills()

	var/class/C = all_classes[class]

	for(var/k in SSexperience.all_skills)
		var/v = SSexperience.all_skills[k]
		var/experience/skill/S = new v(src)
		var/desired_level = C.skills[S.id]
		S.Initialize(S.level_to_xp(clamp(desired_level*level_multiplier,1,100)))
		skills[S.id] = S

/mob/living/proc/update_level()

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

	return (old_level != 0 && old_level < level)

/mob/living/proc/on_level_up(var/experience/E,var/old_level,var/new_level)

	to_chat(span("notice","Your [E.name] increased to [new_level]."))

	if(new_level > old_level)
		switch(E.id)
			if(ATTRIBUTE_STRENGTH,ATTRIBUTE_FORTITUDE)
				add_attribute_xp(ATTRIBUTE_VITALITY,new_level-old_level)
			if(ATTRIBUTE_DEXTERITY,ATTRIBUTE_RESILIENCE)
				add_attribute_xp(ATTRIBUTE_ENDURANCE,new_level-old_level)
			if(ATTRIBUTE_INTELLIGENCE,ATTRIBUTE_WILLPOWER)
				add_attribute_xp(ATTRIBUTE_WISDOM,new_level-old_level)

	return TRUE
