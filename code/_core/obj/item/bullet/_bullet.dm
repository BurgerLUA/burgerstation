/obj/item/bullet/ //NOT TO BE CONFUSED WITH PROJECTILES.
	name = "bullet"
	desc = "Try not to bite it."
	desc_extended = "Bullets can be put in guns with the matching ammo type. Some bullets are very rare and should only be used when needed."
	id = "bullet"
	var/is_spent = FALSE
	icon_state = "bullet"

	item_count_max_icon = 1
	item_count_max = 1
	item_count_current = 1 //How many bullets are in this object?

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

	var/obj/projectile/projectile //The projectile to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/list/shoot_sounds //The shoots sounds to create when the bullet is fired. Optional. Overrides the gun's settings.
	var/base_spread = 0 //The added spread of this type of bullet. Optional. Adds to the gun's settings.
	var/projectile_count = 1 //The amount of projectiles shot out of this bullet. Optional. Overrides the gun's settings.
	var/bullet_speed = TILE_SIZE - 1 //The speed of the bullet, in pixels per tick. Optional. Overrides the gun's settings.

/obj/item/bullet/proc/get_ammo_count()
	return item_count_current


/obj/item/bullet/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

/obj/item/bullet/update_icon()

	if(!is_spent)
		icon_state = "[initial(icon_state)]_[min(item_count_max_icon,item_count_current)]"
	else
		icon_state = "[initial(icon_state)]_spent"
		if(item_count_current <= 1 && is_turf(src.loc))
			pixel_x = rand(-8,8)
			pixel_y = rand(-8,8)

	..()

/obj/item/bullet/get_examine_text(var/mob/examiner)

	. = ..()

	if(is_spent)
		. += div("notice","It is spent.")

	if(item_count_current > 1)
		. += div("notice","It contains [item_count_current] [src.name]\s.")

	return .

/obj/item/bullet/proc/spend_bullet()
	is_spent = TRUE
	queue_delete(src,600)

/obj/item/bullet/proc/transfer_src_to_bullet(var/mob/caller as mob,var/obj/item/bullet/transfer_target,location,control,params,var/display_message = TRUE)

	if(src.is_spent)
		caller.to_chat(span("notice","The bullet is spent!"))
		return FALSE

	if(src == transfer_target)
		return FALSE //TODO: THIS USED TO BE TRUE, TEST BULLETS TO SEE IF THIS SHOULD BE TRUE

	if(id != transfer_target.id)
		caller.to_chat(span("notice","It wouldn't be a good idea to mix different bullet types."))
		return FALSE

	if(transfer_target.item_count_max <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","You have difficulty holding this many bullets at once."))
		return FALSE

	var/transfered_bullets = 0
	var/bullets_to_add = min(item_count_current,transfer_target.item_count_max - transfer_target.get_ammo_count())
	for(var/i=1,i<=bullets_to_add,i++)
		transfer_target.item_count_current += 1
		item_count_current -= 1
		transfered_bullets += 1
	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] bullet\s into \the [transfer_target]."))
	transfer_target.update_icon()
	if(item_count_current <= 0)
		src.drop_item()
		qdel(src)
	else
		update_icon()

	return TRUE

/obj/item/bullet/proc/transfer_src_to_magazine(var/mob/caller as mob,var/obj/item/magazine/transfer_target,location,control,params,var/display_message = TRUE)

	if(src.is_spent)
		caller.to_chat(span("notice","The bullet is spent!"))
		return FALSE

	if(id != transfer_target.bullet_type)
		caller.to_chat(span("notice","You can't insert this type of bullet into this magazine."))
		return FALSE

	if(transfer_target.bullet_count_max <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","The magazine is full."))
		return FALSE

	var/transfered_bullets = 0
	var/bullets_to_add = min(item_count_current,transfer_target.bullet_count_max - transfer_target.get_ammo_count())
	for(var/i=1,i<=bullets_to_add,i++)
		var/obj/item/bullet/B = new src.type(transfer_target)
		transfer_target.stored_bullets += B
		item_count_current -= 1
		transfered_bullets += 1
	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] bullet\s into \the [transfer_target]."))
	transfer_target.update_icon()
	if(item_count_current <= 0)
		src.drop_item()
		qdel(src)
	else
		update_icon()

	return TRUE

/obj/item/bullet/proc/transfer_src_to_gun(var/mob/caller as mob,var/obj/item/weapon/ranged/bullet/transfer_target,location,control,params,var/display_message = TRUE)

	if(src.is_spent)
		caller.to_chat(span("notice","The bullet is spent!"))
		return FALSE

	if(!transfer_target.open)
		caller.to_chat(span("notice","You must open \the [transfer_target] first before loading it!"))
		return FALSE

	if(transfer_target.bullet_type != id)
		caller.to_chat(span("notice","You can't insert this type of bullet into \the [src]!"))
		return FALSE

	if(transfer_target.bullet_count_max <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","You can't fit any more bullets into \the [src]!"))
		return FALSE

	var/transfered_bullets = 0
	var/transfer_self = FALSE

	var/bullets_to_add = min(item_count_current,transfer_target.bullet_count_max - transfer_target.get_ammo_count(),transfer_target.insert_limit)

	if(!bullets_to_add)
		LOG_ERROR("Warning! Something went wrong when trying to insert [src] into [transfer_target]!")
		return FALSE

	for(var/i=1,i<=bullets_to_add,i++)
		transfered_bullets += 1
		if(item_count_current == 1)
			transfer_self = TRUE
			break
		var/obj/item/bullet/B = new src.type(transfer_target)
		transfer_target.stored_bullets += B
		item_count_current -= 1

	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] [src.name]\s into \the [transfer_target]."))

	if(transfer_self)
		src.drop_item(transfer_target)
		transfer_target.stored_bullets += src
		update_icon()
		transfer_target.update_icon()
	else
		transfer_target.update_icon()
		if(item_count_current <= 0)
			src.drop_item()
			qdel(src)
		else
			update_icon()

	return TRUE

/obj/item/bullet/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(is_bullet(object))
		var/obj/item/bullet/B = object
		B.transfer_src_to_bullet(caller,src,location,control,params)
		return TRUE

	if(is_magazine(object))
		var/obj/item/magazine/M = object
		transfer_src_to_magazine(caller,M,location,control,params)
		return TRUE

	if(is_bullet_gun(object))
		var/obj/item/weapon/ranged/bullet/G = object
		transfer_src_to_gun(caller,G,location,control,params)
		return TRUE

	return TRUE