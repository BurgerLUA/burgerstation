/mob/living/update_eyes()

	. = ..()

	var/drug_mod = STATUS_EFFECT_MAGNITUDE(src,DRUGGY)
	if(drug_mod >= 80)
		sight |= SEE_OBJS
		if(drug_mod >= 100)
			sight |= SEE_MOBS

	if(dead)
		vision |= (FLAG_VISION_MEDICAL | FLAG_VISION_SECURITY)
	else if(has_status_effect(src,BLIND))
		vision |= BLIND

/mob/living/get_lighting_alpha()
	return max(0,255 - src.get_mob_value("nightvision"))