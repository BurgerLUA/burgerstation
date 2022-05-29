#define ADDITION "add"
#define MULTIPLICATION "mul"

/mob/living/proc/add_mob_value(var/id,var/value_type,var/value=0,var/math_type=ADDITION)

	if(!mob_value["[value_type]_[math_type]"])
		mob_value["[value_type]_[math_type]"] = list()

	mob_value["[value_type]_[math_type]"][id] = value

	return TRUE

/mob/living/proc/remove_mob_value(var/id,var/value_type)

	. = FALSE

	if(!mob_value)
		return .

	var/add_text = "[value_type]_[ADDITION]"
	if(mob_value[add_text])
		mob_value[add_text] -= id
		. = TRUE

	var/mul_text = "[value_type]_[MULTIPLICATION]"
	if(mob_value[mul_text])
		mob_value[mul_text] -= id
		. = TRUE

	return .


/mob/living/proc/get_mob_value(var/value_type)

	var/add = 0
	var/mul = 1

	var/add_text = "[value_type]_[ADDITION]"
	if(mob_value[add_text])
		for(var/id in mob_value[add_text])
			var/value = mob_value[add_text][id]
			add += value

	var/mul_text = "[value_type]_[MULTIPLICATION]"
	if(mob_value[mul_text])
		for(var/id in mob_value[mul_text])
			var/value = mob_value[mul_text][id]
			mul += value

	return add * mul