/mob/living/get_xp_multiplier()
	return 1

/mob/living/proc/initialize_attributes()

	var/class/C = all_classes[class]

	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.Initialize(A.level_to_xp(C.attributes[A.id]))
		attributes[A.id] = A

/mob/living/proc/initialize_skills()

	var/class/C = all_classes[class]

	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.Initialize(S.level_to_xp(C.skills[S.id]))
		skills[S.id] = S

/mob/living/proc/update_level()

	var/total_attribute_mod = 0
	var/total_skill_mod = 0

	var/total_attributes = 0
	var/total_skills = 0

	for(var/k in attributes)
		var/experience/attribute/A = attributes[k]
		if(A.counts_towards_level)
			total_attribute_mod += (A.get_current_level() - A.default_level)/A.max_level
			total_attributes += 1

	for(var/k in skills)
		var/experience/skill/S = skills[k]
		if(S.counts_towards_level)
			total_skill_mod += (S.get_current_level() - S.default_level)/S.max_level
			total_skills += 1

	if(!total_skills || !total_attributes)
		world.log << "ERROR: FOUND [total_skills] SKILLS AND [total_attributes] ATTRIBUTES."
		return FALSE

	total_attribute_mod = total_attribute_mod/total_attributes
	total_skill_mod = total_skill_mod/total_skills

	var/old_level = level

	level = floor(1 + (total_attribute_mod*0.75 + total_skill_mod*0.25)*(LEVEL_CAP-1))

	return (old_level != 0 && old_level < level)