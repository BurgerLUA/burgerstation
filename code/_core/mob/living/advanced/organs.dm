/mob/living/advanced/proc/remove_all_organs(do_delete=TRUE,turf/T)

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

/mob/living/advanced/proc/add_organ(obj/item/organ/O)
	O = new O(src)
	if(!health) O.health = null
	return attach_organ(O)

/mob/living/advanced/proc/attach_organ(obj/item/organ/O,initialize=TRUE)

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

/obj/item/clothing/back/wings/handle_overlays(mob/living/advanced/A,add=FALSE,remove=FALSE,update=FALSE,worn=FALSE,icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]_behind")
		A.remove_overlay("\ref[src]_front")

	if(add)
		if(worn)
			A.add_overlay_tracked(
				"\ref[src]_behind",
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
				"\ref[src]_front",
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
			A.update_overlay_tracked("\ref[src]_behind",desired_color=src.color)
			A.update_overlay_tracked("\ref[src]_front",desired_color=src.color)


/obj/item/organ/handle_overlays(mob/living/advanced/A,add=FALSE,remove=FALSE,update=FALSE,worn=FALSE,icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]",
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

/obj/item/organ/antennae/handle_overlays(mob/living/advanced/A,add=FALSE,remove=FALSE,update=FALSE,worn=FALSE,icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]_behind")
		A.remove_overlay("\ref[src]_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_behind",
			src,
			desired_layer = LAYER_MOB_ANTENNAE_BEHIND,
			desired_icon_state = "[src.icon_state]_BEHIND",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y =src.worn_pixel_y
		)
		A.add_overlay_tracked(
			"\ref[src]_front",
			src,
			desired_layer = LAYER_MOB_ANTENNAE_FRONT,
			desired_icon_state = "[src.icon_state]_FRONT",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)

	if(update)
		A.update_overlay_tracked("\ref[src]_behind")
		A.update_overlay_tracked("\ref[src]_front")

	return TRUE

/obj/item/organ/wings/handle_overlays(mob/living/advanced/A,add=FALSE,remove=FALSE,update=FALSE,worn=FALSE,icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]_behind")
		A.remove_overlay("\ref[src]_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_behind",
			src,
			desired_layer = LAYER_MOB_WINGS_BEHIND,
			desired_icon_state = "[src.icon_state]_BEHIND",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)
		A.add_overlay_tracked(
			"\ref[src]_front",
			src,
			desired_layer = LAYER_MOB_WINGS_FRONT,
			desired_icon_state = "[src.icon_state]_FRONT",
			desired_pixel_x = src.worn_pixel_x,
			desired_pixel_y = src.worn_pixel_y
		)

	if(update)
		A.update_overlay_tracked("\ref[src]_behind")
		A.update_overlay_tracked("\ref[src]_front")


	return TRUE

/obj/item/organ/tail/handle_overlays(mob/living/advanced/A,add=FALSE,remove=FALSE,update=FALSE,worn=FALSE,icon_state_override)

	if(remove)
		A.remove_overlay("\ref[src]_behind")
		A.remove_overlay("\ref[src]_front")

	if(add)
		A.add_overlay_tracked(
			"\ref[src]_behind",
			src,
			desired_layer = LAYER_MOB_TAIL_BEHIND,
			desired_icon_state = "tail_behind"
		)
		A.add_overlay_tracked(
			"\ref[src]_front",
			src,
			desired_layer = LAYER_MOB_TAIL_FRONT,
			desired_icon_state = "tail_front"
		)

	if(update)
		A.update_overlay_tracked("\ref[src]_behind")
		A.update_overlay_tracked("\ref[src]_front")


	return TRUE

/mob/living/advanced/proc/remove_organ(obj/item/organ/O,turf/T,do_delete = FALSE)

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
		O.update_sprite()

	O.on_organ_remove(src)

	QUEUE_HEALTH_UPDATE(src)