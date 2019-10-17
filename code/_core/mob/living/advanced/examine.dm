mob/living/advanced/get_examine_text(var/mob/examiner)
	. = ..()
	return . + get_flavortext()