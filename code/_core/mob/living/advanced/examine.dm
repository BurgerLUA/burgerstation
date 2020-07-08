mob/living/advanced/get_examine_list(var/mob/examiner)

	var/final_pronoun = "They"
	var/final_pronoun2 = "Their"
	if(examiner == src)
		final_pronoun = "You"
		final_pronoun2 = "Your"

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

		var/blocked_clothing = 0x0

		for(var/obj/item/clothing/C in worn_objects)
			var/bits_to_block = (C.blocks_clothing | C.hidden_clothing) & ~C.item_slot
			blocked_clothing |= bits_to_block

		for(var/obj/item/C in worn_objects)
			if(!is_inventory(C.loc))
				continue
			var/obj/hud/inventory/I = C.loc
			if((C.item_slot & I.item_slot) & blocked_clothing)
				continue
			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[C]'>Strip</a>) [pronoun] is wearing \the <b>[C.name]</b> on their [I.loc.name].")

		for(var/obj/item/I in held_objects)
			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[I]'>Take</a>) [pronoun] is holding \the <b>[I.name]</b> on their [I.loc.name].")

	if(survival_skill >= 50)
		. += div("carryweight","Carry Weight: [capacity]/[max_capacity].")

	if(health)
		if(health.damage[TOX] >= 25)
			. += div("warning","[final_pronoun] looks a bit sickly.")

		if(health.damage[OXY] >= 25)
			. += div("warning","[final_pronoun] looks a bit pale.")

	if(has_status_effect(CRIT))
		. += list(div("warning","[final_pronoun2] breathing is shallow."))

	if(dead)
		if(suicide)
			. += list(div("warning","[final_pronoun] lay dead and lifeless from what appears to be a suicide. There is no hope of recovery."))
		else if(client)
			. += list(div("warning","[final_pronoun] lay dead and lifeless."))
		else
			. += list(div("warning","[final_pronoun] lay dead and lifeless, and their soul has departed."))

	if(ai && ai.use_alerts)
		switch(ai.alert_level)
			if(ALERT_LEVEL_NONE)
				. += list(div("notice","[final_pronoun] do not appear to notice you."))
			if(ALERT_LEVEL_NOISE)
				. += list(div("warning","[final_pronoun] seem to be looking for a source of noise."))
			if(ALERT_LEVEL_CAUTION)
				. += list(div("warning","[final_pronoun] seem to be looking for someone."))
			if(ALERT_LEVEL_COMBAT)
				. += list(div("danger","[final_pronoun] appear to be in a combative stance!"))

	for(var/obj/item/organ/O in src.organs)
		if(!O.health)
			continue

		if(!O.hud_id)
			continue

		var/list/damage_desc = O.get_damage_description()

		var/is_injured = length(damage_desc)

		if(!is_injured)
			continue

		var/noun = "Their"
		var/number_text = ""
		if(examiner == src)
			noun = "Your"

		. += div(is_injured ? "warning" : "notice","[noun] [O.name] is [english_list(damage_desc,nothing_text="healthy")][number_text].")

	/*
	if(reagents)
		var/list/reagent_contents = list()
		for(var/k in reagents.stored_reagents)
			var/v = reagents.stored_reagents[k]
			reagent_contents += "[k] ([v]u)"
		. += div("notice","Reagent volume is [reagents.volume_current]/[reagents.volume_max] containing [english_list(reagent_contents)].")
	*/


	if(handcuffed)
		. += div("warning","(<a href='?src=\ref[examiner];uncuff=\ref[src]'>Remove</a>)[final_pronoun] are hancuffed!")

	return .