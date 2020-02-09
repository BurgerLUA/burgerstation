/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_delete = FALSE)

	if(length(O.inventories))
		for(var/obj/hud/inventory/I in O.inventories)
			I.remove_all_objects()
			I.remove_from_owner()

	remove_overlay(O)
	organs -= O
	labeled_organs -= O.id

	if(do_delete)
		qdel(O)

	O.on_organ_remove(src)

/mob/living/advanced/proc/remove_all_organs()

	for(var/obj/item/organ/O in organs)
		remove_organ(O,TRUE)


/*
/mob/living/advanced/proc/update_all_organs()
	labeled_organs = list()
	for(var/obj/item/organ/O in organs)
		if(O.id)
			labeled_organs[O.id] = O
*/

/mob/living/advanced/proc/add_species_organs()

	var/species/S = all_species[species]

	var/initially_disabled = FALSE
	if(client)
		initially_disabled = client.disable_controls
		client.disable_controls = TRUE
	if(sex == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in S.spawning_organs_female)
			add_organ(S.spawning_organs_female[key])
			sleep(TICK_LAG)
	else
		for(var/key in S.spawning_organs_male)
			add_organ(S.spawning_organs_male[key])
			sleep(TICK_LAG)
	if(client && !initially_disabled)
		client.disable_controls = FALSE

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)

	O = new O(src)

	if(labeled_organs[O.attach_flag])
		var/obj/item/organ/A = labeled_organs[O.attach_flag]
		O.attach_to(A)

	organs += O
	labeled_organs[O.id] = O
	O.update_owner(src) //This updates inventories.

	O.Initialize()

	if(is_tail(O))
		add_overlay(O,desired_layer = LAYER_MOB_TAIL_BEHIND, desired_icon_state = "tail_behind")
		add_overlay(O,desired_layer = LAYER_MOB_TAIL_FRONT, desired_icon_state = "tail_front")
	else
		add_overlay(O,desired_layer = O.worn_layer)

	O.on_organ_add(src)

	return O
