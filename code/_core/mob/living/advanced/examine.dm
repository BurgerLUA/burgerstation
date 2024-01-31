/mob/living/advanced/get_damage_description(mob/examiner)

	. = ..()

	if(!.)
		. = ""

	for(var/k in labeled_organs)
		var/obj/item/organ/O = labeled_organs[k]
		var/damage_description = O.get_damage_description(examiner)
		if(!damage_description)
			continue
		. += "<br>[damage_description]"

/mob/living/advanced/get_examine_details_list(mob/examiner)

	var/pronoun = get_pronoun_he_she_it(src)

	. = list()

	if(handcuffed)
		if(examiner == src)
			. += div("danger","You are handcuffed!")
		else
			. += div("warning","(<a href='?src=\ref[examiner];uncuff=\ref[src]'>Remove</a>) [capitalize(pronoun)] is handcuffed!")

	. += ..()


/mob/living/advanced/proc/on_strip(obj/item/I,atom/old_loc)

	for(var/k in inventory_defers)
		var/obj/hud/button/inventory_defer/ID = k
		if(I != ID.referencing)
			continue
		ID.update_vis_contents()

	return TRUE