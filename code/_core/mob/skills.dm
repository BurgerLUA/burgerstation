/mob/proc/get_skill(var/id)
	return skills[id]

/mob/proc/get_skill_level(var/id)
	var/experience/skill/S = get_skill(id)
	return S.get_current_level()

/mob/proc/get_skill_power(var/id,var/min = 0,var/max = 1)
	var/experience/skill/S = get_skill(id)
	return S.get_power(min,max)

/mob/proc/set_skill_level(var/id,var/desired_level)
	var/experience/skill/S = get_skill(id)
	return S.set_level(desired_level)

/mob/proc/get_attribute(var/id)
	return attributes[id]

/mob/proc/get_attribute_level(var/id)
	var/experience/attribute/A = get_attribute(id)
	return A.get_current_level()

/mob/proc/get_attribute_power(var/id,var/min = 0,var/max = 1)
	var/experience/attribute/A = get_attribute(id)
	return A.get_power(min,max)

/mob/proc/set_attribute_level(var/id,var/desired_level)
	var/experience/attribute/A = get_attribute(id)
	return A.set_level(desired_level)