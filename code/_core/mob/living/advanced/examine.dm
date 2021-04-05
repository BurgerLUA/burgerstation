/mob/living/advanced/get_damage_description(var/mob/examiner,var/verbose=FALSE)

	. = ..()

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 999
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)

	for(var/k in src.organs)

		var/obj/item/organ/O = k

		if(!O.health)
			continue

		if(!O.hud_id)
			continue

		var/list/damage_desc = O.get_damage_description(examiner,verbose)
		var/is_injured = length(damage_desc)

		if(!verbose && !is_injured)
			continue

		var/noun
		if(examiner == src)
			noun = "Your"
		else
			noun = get_pronoun_his_her_their(src)

		var/number_text = ""
		if(survival_skill >= 75 || verbose)
			number_text = "([O.health.health_current]/[O.health.health_max])"

		. += div(is_injured ? "warning" : "notice","[noun] [O.name] is [english_list(damage_desc,nothing_text="healthy")][number_text].")

/mob/living/advanced/get_examine_list(var/mob/examiner)

	. = ..()

	. += div("notice bold","<a href='?src=\ref[examiner];view_inventory=\ref[src]'>(View inventory...)</a>")

mob/living/advanced/get_examine_details_list(var/mob/examiner)

	var/pronoun = get_pronoun_he_she_it(src)

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 999
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)

	. = list()

	if(survival_skill >= 50)
		var/move_delay = TICKS_TO_SECONDS(max(1,get_movement_delay()))
		var/steps_per_second = 1/move_delay
		. += div("notice","Speed: [FLOOR(steps_per_second,0.1)] steps per second.")

	if(handcuffed)
		if(examiner == src)
			. += div("danger","You are handcuffed!")
		else
			. += div("warning","(<a href='?src=\ref[examiner];uncuff=\ref[src]'>Remove</a>) [capitalize(pronoun)] is handcuffed!")

	. += ..()


/mob/living/advanced/proc/on_strip(var/obj/item/I,var/atom/old_loc)

	for(var/k in inventory_defers)
		var/obj/hud/button/inventory_defer/ID = k
		ID.update_vis_contents()

	return TRUE