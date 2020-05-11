mob/living/on_right_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/on_left_down(object,location,control,params)
	return src.attack(src,object,params)


mob/living/get_examine_list(var/mob/examiner)

	. = ..()

	var/final_pronoun = "They"
	if(examiner == src)
		final_pronoun = "You"

	if(health)
		if(health.damage[TOX] >= 25)
			. += div("warning","[final_pronoun] looks a bit sickly.")

		if(health.damage[OXY] >= 25)
			. += div("warning","[final_pronoun] looks a bit pale.")

	if(has_status_effect(CRIT))
		. += list(div("warning","They do not appear to be breathing."))

	if(examiner == src)
		for(var/status in status_effects)
			var/status_effect/S = SSstatus.all_status_effects[status]
			. += list(div("warning",S.desc))

	if(dead)
		if(client)
			. += list(div("warning","They lay dead and lifeless."))
		else
			. += list(div("warning","They lay dead and lifeless, and their soul has departed."))

	return .