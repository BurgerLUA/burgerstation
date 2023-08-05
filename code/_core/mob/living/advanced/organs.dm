/mob/living/advanced/proc/remove_all_organs(var/do_delete=TRUE,var/turf/T)

	for(var/k in organs)
		var/obj/item/organ/O = k
		//Prevents redundency.
		if(O.attached_organ)
			O.attached_organ.attached_organs -= O
			O.attached_organ = null
		if(O.attached_organs)
			O.attached_organs.Cut()
		remove_organ(O,T,do_delete)

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

	if(O.enable_overlay) O.handle_overlays(src,add=TRUE,worn=TRUE)

	O.on_organ_add(src)

	return O

/obj/item/clothing/back/wings/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
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

	if(update)
		if(worn)
			A.update_overlay_tracked("\ref[src]_wings_behind",desired_color=src.color)
			A.update_overlay_tracked("\ref[src]_wings_front",desired_color=src.color)


/obj/item/organ/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]_[src.type]")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_[src.type]",
			src,
			desired_layer = src.worn_layer,
			desired_icon_state = icon_state_override,
		)

	if(update)
		A.update_overlay_tracked(
			"\ref[src]",
			desired_icon_state = icon_state_override,
		)


	return TRUE

/obj/item/organ/antennae/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
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

	if(update)
		A.update_overlay_tracked("\ref[src]_antennae_behind")
		A.update_overlay_tracked("\ref[src]_antennae_front")

	return TRUE

/obj/item/organ/wings/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
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

	if(update)
		A.update_overlay_tracked("\ref[src]_wings_behind")
		A.update_overlay_tracked("\ref[src]_wings_front")


	return TRUE

/obj/item/organ/tail/handle_overlays(var/mob/living/advanced/A,var/add=FALSE,var/remove=FALSE,var/update=FALSE,var/worn=FALSE,var/icon_state_override)

	if(remove)
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

	if(update)
		A.update_overlay_tracked("\ref[src]_tail_behind")
		A.update_overlay_tracked("\ref[src]_tail_front")


	return TRUE

/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/turf/T,var/do_delete = FALSE)

	for(var/k in O.inventories)
		var/obj/hud/inventory/I = k
		if(do_delete || !T)
			I.delete_objects()
		else
			var/list/dropped_objects = I.drop_objects(T)
			for(var/j in dropped_objects)
				var/obj/item/I2 = j
				if(I.ultra_persistant)
					qdel(I2)
				else
					animate(I2,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=3)

	if(O.attached_organ)
		O.attached_organ.attached_organs -= O
		O.attached_organ = null

	for(var/k in O.attached_organs)
		var/obj/item/organ/O2 = k
		src.remove_organ(O2,T,do_delete)

	organs -= O
	labeled_organs -= O.id
	queue_organ_health_update -= O

	O.update_owner(null)

	if(O.enable_overlay) O.handle_overlays(src,remove=TRUE)

	if(do_delete)
		qdel(O)
	else
		O.drop_item(T)
		if(O.health)
			O.health.update_health()
		update_sprite()

	O.on_organ_remove(src)

	QUEUE_HEALTH_UPDATE(src)