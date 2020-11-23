/mob/living/proc/dvar_base(var/id,var/value)
	dynamic_variable_base[id] = value
	return value

/mob/living/proc/dvar_mul(var/id,var/value)
	dynamic_variable_mul[id] += value
	return value

/mob/living/proc/dvar_add(var/id,var/value)
	dynamic_variable_add[id] += value
	return value

/mob/living/proc/dvar_get(var/id)
	return (SAFENUM(dynamic_variable_base[id]) * SAFENUM(dynamic_variable_mul[id])) + SAFENUM(dynamic_variable_add[id])