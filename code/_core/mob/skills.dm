/mob/living/Initialize()
	initialize_attributes()
	initialize_skills()
	. = ..()

/mob/living/proc/initialize_attributes()
	for(var/v in all_attributes)
		var/experience/attribute/A = new v(src)
		A.experience = A.level_to_xp(ATTRIBUTE_DEFAULT)
		attributes[A.name] = A

/mob/living/proc/initialize_skills()
	for(var/v in all_skills)
		var/experience/skill/S = new v(src)
		S.experience = S.level_to_xp(SKILL_DEFAULT)
		skills[S.name] = S

/mob/living/proc/get_skill(var/id)
	return skills[id]

/mob/living/proc/get_skill_level(var/id)
	var/experience/skill/S = get_skill(id)
	return S.get_current_level()

/mob/living/proc/get_skill_power(var/id,var/min = 0,var/max = 1)
	var/experience/skill/S = get_skill(id)
	return S.get_power(min,max)

/mob/living/proc/set_skill_level(var/id,var/desired_level)
	var/experience/skill/S = get_skill(id)
	return S.set_level(desired_level)

/mob/living/proc/get_attribute(var/id)
	return attributes[id]

/mob/living/proc/get_attribute_level(var/id)
	var/experience/attribute/A = get_attribute(id)
	return A.get_current_level()

/mob/living/proc/get_attribute_power(var/id,var/min = 0,var/max = 1)
	var/experience/attribute/A = get_attribute(id)
	return A.get_power(min,max)

/mob/living/proc/set_attribute_level(var/id,var/desired_level)
	var/experience/attribute/A = get_attribute(id)
	return A.set_level(desired_level)