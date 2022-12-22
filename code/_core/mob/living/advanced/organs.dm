/mob/living/advanced/proc/remove_all_organs(var/do_delete=TRUE)

	for(var/k in organs)
		var/obj/item/organ/O = k
		remove_organ(O,do_delete)

	return TRUE

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)
	O = new O(src)
	if(!health) O.health = null
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

	if(O.enable_overlay) O.handle_overlays(src,add=TRUE,worn=FALSE)

	O.on_organ_add(src)

	return O


/obj/item/proc/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE,var/icon_state_override)

	A.remove_overlay("\ref[src]")

	if(add)
		if(worn)
			var/obj/hud/inventory/I = src.loc
			var/desired_layer = src.worn_layer
			if(I.advanced_layering && length(I.contents) > 1)
				var/key = I.contents.Find(src)
				if(key != 1)
					var/obj/item/I2 = I.contents[1]
					desired_layer = I2.worn_layer + (key)*0.01
			A.add_overlay_tracked(
				"\ref[src]",
				src,
				desired_layer = desired_layer,
				desired_icon = initial(src.icon),
				desired_icon_state = icon_state_override ? icon_state_override : initial(src.icon_state),
				desired_no_initial = src.no_initial_blend,
				desired_pixel_x = src.worn_pixel_x,
				desired_pixel_y = src.worn_pixel_y,
				desired_color=src.color
			)


	return TRUE

/obj/item/clothing/back/wings/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE,var/icon_state_override)

	A.remove_overlay("\ref[src]_wings_behind")
	A.remove_overlay("\ref[src]_wings_front")

	if(add)
		if(worn)
			A.add_overlay_tracked(
				"\ref[src]_wings_behind",
				src,
				desired_layer = LAYER_MOB_WINGS_BEHIND,
				desired_icon = initial(src.icon),
				desired_icon_state = "worn_behind",
				desired_no_initial = src.no_initial_blend,
				desired_pixel_x = src.worn_pixel_x,
				desired_pixel_y = src.worn_pixel_y,
				desired_color = src.color
			)
			A.add_overlay_tracked(
				"\ref[src]_wings_front",
				src,
				desired_layer = LAYER_MOB_WINGS_FRONT,
				desired_icon=initial(src.icon),
				desired_icon_state = "worn_front",
				desired_no_initial = src.no_initial_blend,
				desired_pixel_x = src.worn_pixel_x,
				desired_pixel_y = src.worn_pixel_y,
				desired_color = src.color
			)



/obj/item/organ/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE)

	A.remove_overlay("\ref[src]")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]",
			src,
			desired_layer = src.worn_layer
		)


	return TRUE

/obj/item/organ/antennae/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE)

	A.remove_overlay("\ref[src]_antennae_behind")
	A.remove_overlay("\ref[src]_antennae_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_antennae_behind",
			src,
			desired_layer = LAYER_MOB_ANTENNAE_BEHIND,
			desired_icon_state = "[src.icon_state]_BEHIND",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y =src.worn_pixel_y
		)
		A.add_overlay_tracked(
			"\ref[src]_antennae_front",
			src,
			desired_layer = LAYER_MOB_ANTENNAE_FRONT,
			desired_icon_state = "[src.icon_state]_FRONT",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)

	return TRUE

/obj/item/organ/wings/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE)

	A.remove_overlay("\ref[src]_wings_behind")
	A.remove_overlay("\ref[src]_wings_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_wings_behind",
			src,
			desired_layer = LAYER_MOB_WINGS_BEHIND,
			desired_icon_state = "[src.icon_state]_BEHIND",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)
		A.add_overlay_tracked(
			"\ref[src]_wings_front",
			src,
			desired_layer = LAYER_MOB_WINGS_FRONT,
			desired_icon_state = "[src.icon_state]_FRONT",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)

	return TRUE

/obj/item/organ/tail/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/worn=FALSE)

	A.remove_overlay("\ref[src]_tail_behind")
	A.remove_overlay("\ref[src]_tail_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_tail_behind",
			src,
			desired_layer = LAYER_MOB_TAIL_BEHIND,
			desired_icon_state = "tail_behind"
		)
		A.add_overlay_tracked(
			"\ref[src]_tail_front",
			src,
			desired_layer = LAYER_MOB_TAIL_FRONT,
			desired_icon_state = "tail_front"
		)

	return TRUE

/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_delete = FALSE)

	var/turf/T = get_turf(src)

	for(var/k in O.inventories)
		var/obj/hud/inventory/I = k
		if(do_delete)
			I.delete_objects()
		else
			I.drop_objects(T)

	O.update_owner(null)

	if(O.enable_overlay) O.handle_overlays(src,add=FALSE)

	organs -= O
	labeled_organs -= O.id

	if(do_delete)
		qdel(O)

	O.on_organ_remove(src)