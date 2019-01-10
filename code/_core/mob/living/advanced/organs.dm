/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O)
	organs.Remove(O)
	update_organs()
	O = null
	del(O)
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

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)
	O = new O
	organs += O
	if(O.id)
		labeled_organs[O.id] = O

	O.update_owner(src)