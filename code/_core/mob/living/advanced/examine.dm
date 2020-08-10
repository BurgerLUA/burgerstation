/mob/living/advanced/get_examine_list(var/mob/examiner)

	var/pronoun = get_pronoun(src)

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 50
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)

	. = ..()

	if(examiner != src)
		var/blocked_clothing = 0x0
		for(var/obj/item/clothing/C in worn_objects)
			var/bits_to_block = (C.blocks_clothing | C.hidden_clothing) & ~C.item_slot
			blocked_clothing |= bits_to_block
		for(var/k in worn_objects)
			var/obj/item/C = k
			if(!is_inventory(C.loc))
				continue
			var/obj/hud/inventory/I = C.loc
			if((C.item_slot & I.item_slot) & blocked_clothing)
				continue
			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[C]'>Strip</a>) [capitalize(pronoun)] is wearing \the <b>[C.name]</b> on their [initial(I.loc.name)].")
		for(var/k in held_objects)
			var/obj/item/I = k
			. += div("notice","(<a href='?src=\ref[examiner];take=\ref[I]'>Take</a>) [capitalize(pronoun)] is holding \the <b>[I.name]</b> on their [initial(I.loc.name)].")

	for(var/k in src.organs)

		var/obj/item/organ/O = k

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
		if(survival_skill >= 75)
			number_text = "([O.health.health_current]/[O.health.health_max])"

		. += div(is_injured ? "warning" : "notice","[noun] [O.name] is [english_list(damage_desc,nothing_text="healthy")][number_text].")

	return .

mob/living/advanced/get_examine_details_list(var/mob/examiner)

	var/pronoun = get_pronoun(src)

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 999
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)

	. = list()

	if(survival_skill >= 50)
		var/move_penalty = 100 - CEILING(100*(1/slowdown_mul),1)
		if(move_penalty > 0)
			. += div("red","Equipment Move Penalty: [move_penalty]%.")
		else if(move_penalty < 0)
			. += div("green","Equipment Move Bonus: [-move_penalty]%.")

	if(handcuffed)
		. += div("warning","(<a href='?src=\ref[examiner];uncuff=\ref[src]'>Remove</a>)[capitalize(pronoun)] is handcuffed!")

	. += ..()

	return .