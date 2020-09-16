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