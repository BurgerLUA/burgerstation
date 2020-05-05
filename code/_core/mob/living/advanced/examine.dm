mob/living/advanced/get_examine_list(var/mob/examiner)

	. = list()

	var/survival_skill = 1

	if(examiner == src || is_observer(examiner))
		survival_skill = 999

	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)

	. += div("examine_title",src.name)
	. += div("examine_description","\"[src.desc]\"")
	. += div("examine_description_long",get_flavortext())

	var/pronoun = capitalize(get_pronoun(src))

	if(examiner != src)
		for(var/obj/item/I in worn_objects)
			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[I]'>Strip</a>) [pronoun] is wearing \the <b>[I.name]</b> on their [I.loc.loc.name].")

		for(var/obj/item/I in held_objects)

			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[I]'>Take</a>) [pronoun] is holding \the <b>[I.name]</b> on their [I.loc.loc.name].")

	var/final_pronoun = "They"
	if(examiner == src)
		final_pronoun = "You"

	if(survival_skill > 50)
		. += div("carryweight","Carry Weight: [capacity]/[max_capacity].")

	if(health)
		if(health.damage[TOX] >= 25)
			. += div("warning","[final_pronoun] looks a bit sickly.")

		if(health.damage[OXY] >= 25)
			. += div("warning","[final_pronoun] looks a bit pale.")

	if(has_status_effect(CRIT))
		. += list(div("warning","They do not appear to be breathing."))

	if(dead)
		if(client)
			. += list(div("warning","They lay dead and lifeless."))
		else
			. += list(div("warning","They lay dead and lifeless, and their soul has departed."))

	for(var/obj/item/organ/O in src.organs)
		if(!O.health)
			continue

		if(!O.hud_id)
			continue

		var/list/damage_desc = O.get_damage_description()

		var/is_injured = length(damage_desc)

		var/noun = "Their"
		var/number_text = ""
		if(examiner == src)
			noun = "Your"
			//number_text = " ([O.health.health_current]/[O.health.health_max])"
		else if(!is_injured)
			continue
		else
			number_text = ""

		. += div(is_injured ? "warning" : "notice","[noun] [O.name] is [english_list(damage_desc,nothing_text="healthy")][number_text].")

	/*
	if(reagents)
		var/list/reagent_contents = list()
		for(var/k in reagents.stored_reagents)
			var/v = reagents.stored_reagents[k]
			reagent_contents += "[k] ([v]u)"
		. += div("notice","Reagent volume is [reagents.volume_current]/[reagents.volume_max] containing [english_list(reagent_contents)].")
	*/

	return .