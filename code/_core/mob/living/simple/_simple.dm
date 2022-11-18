/mob/living/simple
	//soul_size = SOUL_SIZE_COMMON
	ai = /ai/
	loyalty_tag = null
	iff_tag = null

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

/mob/living/simple/pre_death()
	status_immune = list()
	. = ..()
