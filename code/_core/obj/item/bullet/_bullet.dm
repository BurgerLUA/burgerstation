/obj/item/bullet/ //NOT TO BE CONFUSED WITH PROJECTILES.
	name = "bullet"
	desc = "just a regular bullet"
	id = "bullet"
	var/is_spent = FALSE
	icon_state = "bullet"
	var/bullet_count = 1

	var/bullet_capacity_icon = 1
	var/bullet_capacity = 1

	item_slot = SLOT_GROIN_O
	worn_layer = LAYER_MOB_CLOTHING_BACK

/obj/item/bullet/proc/get_ammo_count()
	return bullet_count

/obj/item/bullet/shotgun/on_spawn()
	bullet_count = 3

/obj/item/bullet/update_icon()

	if(!is_spent)
		icon_state = "[initial(icon_state)]_[min(bullet_capacity_icon,bullet_count)]"
	else
		icon_state = "[initial(icon_state)]_spent"
		if(bullet_count <= 1)
			pixel_x = rand(-8,8)
			pixel_y = rand(-8,8)

	..()

/obj/item/bullet/examine(var/atom/examiner)
	..()
	if(is_spent)
		examiner.to_chat("It is spent.")

	if(bullet_count > 1)
		examiner.to_chat("It contains [bullet_count] bullets.")

/obj/item/bullet/proc/spend_bullet()
	is_spent = TRUE
	update_icon()
	queue_delete(src,600)

/obj/item/bullet/proc/transfer_src_to_bullet(var/mob/caller as mob,var/obj/item/bullet/transfer_target,location,control,params,var/display_message = TRUE)

	if(src.is_spent)
		caller.to_chat(span("notice","The bullet is spent!"))
		return FALSE

	if(src == transfer_target)
		return TRUE

	if(id != transfer_target.id)
		caller.to_chat(span("notice","It wouldn't be a good idea to mix different bullet types."))
		return FALSE

	if(transfer_target.bullet_capacity <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","You have difficulty holding this many bullets at once."))
		return FALSE

	var/transfered_bullets = 0
	var/bullets_to_add = min(bullet_count,transfer_target.bullet_capacity - transfer_target.get_ammo_count())
	for(var/i=1,i<=bullets_to_add,i++)
		transfer_target.bullet_count += 1
		bullet_count -= 1
		transfered_bullets += 1
	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] bullet\s into \the [transfer_target]."))
	transfer_target.update_icon()
	if(bullet_count <= 0)
		src.drop_item()
		del(src)
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

	if(transfer_target.bullet_capacity <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","The magazine is full."))
		return FALSE

	var/transfered_bullets = 0
	var/bullets_to_add = min(bullet_count,transfer_target.bullet_capacity - transfer_target.get_ammo_count())
	for(var/i=1,i<=bullets_to_add,i++)
		var/obj/item/bullet/B = new src.type(transfer_target.loc)
		transfer_target.stored_bullets += B
		bullet_count -= 1
		transfered_bullets += 1
	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] bullet\s into \the [transfer_target]."))
	transfer_target.update_icon()
	if(bullet_count <= 0)
		src.drop_item()
		del(src)
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

	if(transfer_target.bullet_capacity <= transfer_target.get_ammo_count())
		caller.to_chat(span("notice","You can't fit any more bullets into \the [src]!"))
		return FALSE

	var/transfered_bullets = 0
	var/transfer_self = FALSE

	var/bullets_to_add = min(bullet_count,transfer_target.bullet_capacity - transfer_target.get_ammo_count())
	for(var/i=1,i<=bullets_to_add,i++)
		bullet_count -= 1
		transfered_bullets += 1
		if(bullet_count == 0)
			transfer_self = TRUE
			break
		var/obj/item/bullet/B = new src.type(transfer_target.loc)
		transfer_target.stored_bullets += B

	if(display_message)
		caller.to_chat(span("notice","You insert [transfered_bullets] bullet\s into \the [transfer_target]."))

	transfer_target.update_icon()

	if(transfer_self)
		src.drop_item(transfer_target.loc)
		transfer_target.stored_bullets += src
		update_icon()
	else
		if(bullet_count <= 0)
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