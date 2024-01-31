//New system is called mob_values.

/mob/living/proc/dvar_base(id,value)
	dynamic_variable_base[id] = value
	return value

/mob/living/proc/dvar_mul(id,value)
	dynamic_variable_mul[id] += value
	return value

/mob/living/proc/dvar_add(id,value)
	dynamic_variable_add[id] += value
	return value

/mob/living/proc/dvar_get(id)
	return (SAFENUM(dynamic_variable_base[id]) * SAFENUM(dynamic_variable_mul[id])) + SAFENUM(dynamic_variable_add[id])