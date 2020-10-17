/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_delete = FALSE)

	if(length(O.inventories))
		for(var/k in O.inventories)
			var/obj/hud/inventory/I = k
			I.delete_all_objects()
			I.remove_from_owner()

	if(is_tail(O))
		remove_overlay("tail_behind")
		remove_overlay("tail_front")
	else
		remove_overlay("\ref[O]")
	organs -= O
	labeled_organs -= O.id

	if(do_delete)
		qdel(O)

	O.on_organ_remove(src)

/mob/living/advanced/proc/remove_all_organs(var/do_delete=TRUE)
	for(var/k in organs)
		var/obj/item/organ/O = k
		remove_organ(O,do_delete)

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)
	O = new O(src)
	return attach_organ(O)

/mob/living/advanced/proc/attach_organ(var/obj/item/organ/O,var/initialize=TRUE)

	if(labeled_organs[O.attach_flag])
		var/obj/item/organ/A = labeled_organs[O.attach_flag]
		O.attach_to(A)

	organs += O
	labeled_organs[O.id] = O
	O.update_owner(src) //This updates inventories.

	if(initialize)
		INITIALIZE(O)
		FINALIZE(O)

	if(is_tail(O))
		add_overlay_tracked("tail_behind",O,desired_layer = LAYER_MOB_TAIL_BEHIND, desired_icon_state = "tail_behind")
		add_overlay_tracked("tail_front",O,desired_layer = LAYER_MOB_TAIL_FRONT, desired_icon_state = "tail_front")
	else
		add_overlay_tracked("\ref[O]",O,desired_layer = O.worn_layer)

	O.on_organ_add(src)

	return O