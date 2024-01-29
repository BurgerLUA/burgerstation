#define ADDITION "add"
#define MULTIPLICATION "mul"

/mob/living/proc/add_mob_value(id,value_type,value=0,math_type=ADDITION)

	. = FALSE

	if(math_type == ADDITION)
		if(!mob_value_add[value_type])
			mob_value_add[value_type] = list()
		mob_value_add[value_type][id] = value
		. = TRUE

	else if(math_type == MULTIPLICATION)
		if(!mob_value_mul[value_type])
			mob_value_mul[value_type] = list()
		mob_value_mul[value_type][id] = value
		. = TRUE

	return .

/mob/living/proc/remove_mob_value(id,value_type,math_type=ADDITION)

	. = FALSE

	if(math_type == ADDITION)
		if(mob_value_add[value_type])
			mob_value_add[value_type] -= id
	else if(math_type == MULTIPLICATION)
		if(mob_value_mul[value_type])
			mob_value_mul[value_type] -= id

	return .


/mob/living/proc/get_mob_value(value_type)

	var/add = 0
	var/mul = 1

	if(mob_value_add[value_type])
		for(var/id in mob_value_add[value_type])
			add += mob_value_add[value_type][id]

	if(mob_value_mul[value_type])
		for(var/id in mob_value_mul[value_type])
			mul += mob_value_mul[value_type][id] = value

	return add * mul