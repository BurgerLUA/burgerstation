/mob/living/update_eyes()

	. = ..()

	var/drug_mod = STATUS_EFFECT_MAGNITUDE(src,DRUGGY)
	if(drug_mod >= 80)
		sight |= SEE_OBJS
		if(drug_mod >= 100)
			sight |= SEE_MOBS
			sight &= ~BLIND

	if(dead)
		vision |= (FLAG_VISION_MEDICAL | FLAG_VISION_SECURITY)