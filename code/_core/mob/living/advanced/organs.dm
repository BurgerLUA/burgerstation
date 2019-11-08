/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_update = TRUE,var/do_delete = FALSE)

	if(length(O.inventories))
		for(var/obj/hud/inventory/I in O.inventories)
			I.remove_all_objects()
			I.update_owner()


	remove_overlay(O)
	organs -= O
	labeled_organs -= O

	if(do_delete)
		qdel(O)

/mob/living/advanced/proc/remove_all_organs()
	for(var/obj/item/organ/O in organs)
		remove_organ(O,FALSE,TRUE)

/mob/living/advanced/proc/update_all_organs()
	labeled_organs = list()
	for(var/obj/item/organ/O in organs)
		if(O.id)
			labeled_organs[O.id] = O

/mob/living/advanced/proc/add_species_organs()

	var/species/S = all_species[species]

	if(sex == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in S.spawning_organs_female)
			var/obj/item/organ/O = add_organ(S.spawning_organs_female[key])
			if(O.reagents)
				O.reagents.add_reagent("blood",floor(O.reagents.volume_max*0.5))
	else
		for(var/key in S.spawning_organs_male)
			var/obj/item/organ/O = add_organ(S.spawning_organs_male[key])
			if(O.reagents)
				O.reagents.add_reagent("blood",floor(O.reagents.volume_max*0.5))

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)

	O = new O(src)

	if(labeled_organs[O.attach_flag])
		var/obj/item/organ/A = labeled_organs[O.attach_flag]
		O.attach_to(A)

	organs += O
	labeled_organs[O.id] = O
	O.update_owner(src)

	if(is_tail(O))
		add_overlay(O,desired_layer = LAYER_MOB_TAIL_BEHIND, desired_icon_state = "tail_behind")
		add_overlay(O,desired_layer = LAYER_MOB_TAIL_FRONT, desired_icon_state = "tail_front")
	else
		add_overlay(O,desired_layer = O.worn_layer)

	return O

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src
