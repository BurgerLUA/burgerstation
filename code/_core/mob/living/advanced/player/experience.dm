/mob/living/advanced/player/get_skill_power(var/id,var/min_power=0.25,var/max_power=1,var/absolute_max_power)
	var/experience/skill/S = get_skill(id)
	if(!S)
		CRASH_SAFE("Warning! Tried getting skill power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25

	var/bonus = 0
	if(job)
		var/job/J = JOB(job)
		if(length(J.bonus_skills) && J.bonus_skills[id])
			bonus += J.bonus_skills[id]*job_rank

	return S.get_power(min_power,max_power,absolute_max_power,bonus)

/mob/living/advanced/player/get_attribute_power(var/id,var/min_power=0.25,var/max_power=1,var/absolute_max_power)
	var/experience/attribute/A = get_attribute(id)
	if(!A)
		CRASH_SAFE("Warning! Tried getting attribute power of [id], but it didn't exist for [src.get_debug_name()]!")
		return 0.25

	var/bonus = 0
	if(job)
		var/job/J = JOB(job)
		if(length(J.bonus_attributes) && J.bonus_attributes[id])
			bonus += J.bonus_attributes[id]*job_rank

	return A.get_power(min_power,max_power,absolute_max_power,bonus)