/mob/living/update_eyes()

	. = ..()

	if(has_status_effect(DRUGGY))
		var/drug_mod = get_status_effect_magnitude(DRUGGY) * min(1,get_status_effect_duration(DRUGGY)/60)
		if(drug_mod >= 80)
			sight |= SEE_OBJS
			if(drug_mod >= 100)
				sight |= SEE_MOBS
				sight &= ~BLIND
