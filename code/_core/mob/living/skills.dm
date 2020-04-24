//Skills
/mob/living/proc/get_skill(var/id)
	return skills[id]

/mob/living/proc/get_skill_level(var/id)
	var/experience/skill/S = get_skill(id)
	return S.get_current_level()

/mob/living/proc/get_skill_power(var/id)
	var/experience/skill/S = get_skill(id)
	if(!S)
		log_error("Warning! Tried getting skill [id], but it didn't exist for [src.name]([src.type])!")
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
/mob/living/proc/get_attribute(var/id)
	return attributes[id]

/mob/living/proc/get_attribute_level(var/id)
	var/experience/attribute/A = get_attribute(id)
	return A.get_current_level()

/mob/living/proc/get_attribute_power(var/id)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		log_error("Warning! Tried getting attribute [id], but it didn't exist for [src.name]([src.type])!")
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