/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_update = TRUE,var/do_delete = FALSE)
	if(length(O.inventories))
		for(var/obj/inventory/I in O.inventories)
			I.remove_all_objects()
			I.update_owner()

	organs -= O
	if(do_delete)
		del(O)
	if(do_update)
		update_organs()
		update_icon()

/mob/living/advanced/proc/remove_all_organs()
	for(var/obj/item/organ/O in organs)
		remove_organ(O,FALSE,TRUE)
	update_organs()
	update_icon()

/mob/living/advanced/proc/update_organs()
	labeled_organs = list()
	for(var/obj/item/organ/O in organs)
		if(O.id)
			labeled_organs[O.id] = O

/mob/living/advanced/proc/add_species_organs()

	if(gender == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in mob_species.spawning_organs_female)
			add_organ(mob_species.spawning_organs_female[key])
	else
		for(var/key in mob_species.spawning_organs_male)
			add_organ(mob_species.spawning_organs_male[key])

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)

	O = new O
	O.loc = src

	if(labeled_organs[O.attach_flag])
		var/obj/item/organ/A = labeled_organs[O.attach_flag]
		O.attach_to(A)

	organs += O
	if(O.id)
		labeled_organs[O.id] = O
	O.update_owner(src)

	return O