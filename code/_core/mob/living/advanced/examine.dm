/mob/living/advanced/get_damage_description(var/mob/examiner,var/verbose=FALSE)

	. = ..()

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 999
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_power(SKILL_SURVIVAL,0,1,2)*100

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

	var/object_icon = ICON_TO_HTML(icon,icon_state,32,32)
	var/species/S = SPECIES(species)
	. = list(div("examine_title","[object_icon][src.name]"),div("bold","Level [level] [S.name]"),div("examine_description_long",src.desc_extended))

	var/activity_text = get_activity_text()
	if(activity_text)
		. += activity_text

	. += get_damage_description(examiner,FALSE)

	. += div("notice bold","<a href='?src=\ref[examiner];view_inventory=\ref[src]'>(View inventory...)</a>")

mob/living/advanced/get_examine_details_list(var/mob/examiner)

	var/pronoun = get_pronoun_he_she_it(src)

	var/survival_skill = 1
	if(examiner == src || is_observer(examiner))
		survival_skill = 999
	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_power(SKILL_SURVIVAL,0,1,2)*100

	. = list()

	if(survival_skill >= 50)
		var/calculated_speed = (DECISECONDS_TO_TICKS(1.75)/initial(movement_delay))*(1-move_delay_multiplier)*100
		. += div("notice","Speed: [FLOOR(calculated_speed,0.01)]%")
		. += div("notice","Evasion Rating: [FLOOR(evasion_rating,0.01)]%")

	if(handcuffed)
		if(examiner == src)
			. += div("danger","You are handcuffed!")
		else
			. += div("warning","(<a href='?src=\ref[examiner];uncuff=\ref[src]'>Remove</a>) [capitalize(pronoun)] is handcuffed!")

	. += ..()


/mob/living/advanced/proc/on_strip(var/obj/item/I,var/atom/old_loc)

	for(var/k in inventory_defers)
		var/obj/hud/button/inventory_defer/ID = k
		if(I != ID.referencing)
			continue
		ID.update_vis_contents()

	return TRUE