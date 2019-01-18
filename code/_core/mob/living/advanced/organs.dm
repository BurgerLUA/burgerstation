/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_update = TRUE)
	if(length(O.inventories))
		for(var/obj/inventory/I in O.inventories)
			I.remove_all_objects()
			I.update_owner()

	organs -= O
	O = null
	del(O)
	if(do_update)
		update_organs()
		update_icon()


/mob/living/advanced/proc/remove_all_organs()
	for(var/obj/item/organ/O in organs)
		remove_organ(O,FALSE)
	update_organs()
	update_icon()


/mob/living/advanced/proc/update_organs()
	labeled_organs = list()
	for(var/obj/item/organ/O in organs)
		if(O.id)
			labeled_organs[O.id] = O

/mob/living/advanced/proc/add_species_organs()

	if(gender == FEMALE)
		for(var/key in mob_species.spawning_organs_female)
			add_organ(mob_species.spawning_organs_female[key])
	else
		for(var/key in mob_species.spawning_organs_male)
			add_organ(mob_species.spawning_organs_male[key])

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O,var/organ_color)
	O = new O
	O.loc = src
	if(organ_color)
		O.color = organ_color
	organs += O
	if(O.id)
		labeled_organs[O.id] = O

	O.update_owner(src)

	return O