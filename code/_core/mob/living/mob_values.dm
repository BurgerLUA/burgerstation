/mob/living/proc/add_mob_value(var/value_type,var/id,var/value=0)

	if(!mob_value)
		mob_value = list()

	if(!mob_value[value_type])
		mob_value[value_type] = list()

	if(!mob_value[value_type][id])
		mob_value[value_type][id] = value
	else
		mob_value[value_type][id] += value

	return TRUE

/mob/living/proc/remove_mob_value(var/value_type,var/id)

	if(!mob_value)
		return TRUE

	if(!mob_value[value_type])
		return TRUE

	mob_value[value_type] -= id

	return TRUE


/mob/living/proc/get_mob_value(var/value_type)

	. = 0

	if(mob_value && mob_value[value_type])
		for(var/k in mob_value[value_type])
			. += mob_value[value_type]