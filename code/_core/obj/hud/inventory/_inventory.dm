//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/hud/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	id = "BADINVENTORY"

	//icon = 'icons/invisible.dmi'
	//icon_state = "0"

	icon = 'icons/hud/inventory.dmi'
	icon_state = "slot"

	plane = PLANE_HUD

	var/list/obj/item/held_objects //Items that are held, and not worn.
	var/list/obj/item/worn_objects //Items that are worn, and not held.

	var/held_slots = 1 //How many items this object can hold.
	var/max_weight = -1 //Maximum weight this inventory object can hold. -1 basically means it can't hold anything.
	var/max_size = -1 //Maximum amount of size this object can hold. -1 basically means it can't hold anything.

	var/worn_slots = 1 //How many items this object can wear

	var/total_weight = 0 //Var storage value that is updated every time an item is changed.
	var/total_size = 0 //Var storage value that is updated every time an item is changed.

	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to clothing only.

	var/priority = 0 //The priority level of the inventory. Item transfer favors inventories with higher values.

	var/list/obj/item/item_blacklist = list() //Items that can't go in this invetory.
	var/list/obj/item/item_whitelist = list() //Items that can only go in this inventory.
	var/list/obj/item/item_bypass = list() //Items that bypass any size and weight requirements.

	var/mob/living/advanced/owner //The mob that owns this object. Only living things should be able to store items.

	var/click_flags

	var/flags = FLAGS_HUD_INVENTORY

	var/should_draw = TRUE //Should the item's held icon be displayed?
	var/reverse_draw = FALSE //Should the worn state and the held state be swapped?

	var/drag_to_take = TRUE //You must click and drag to take the object inside.

	var/obj/hud/inventory/parent_inventory //Basically one massive defer to this inventory.
	var/obj/hud/inventory/child_inventory

	var/atom/movable/grabbed_object

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = TRUE

	var/essential = FALSE //Should this be drawn when the inventory is hidden?
	var/is_container = FALSE //Set to true if it uses the container inventory system.

	var/x_offset_initial = 0
	var/y_offset_initial = 0

	var/x_offset_mul = 0
	var/y_offset_mul = 0

	var/draw_extra = FALSE

/obj/hud/inventory/proc/show(var/should_show,var/speed)
	if(should_show)
		animate(src,alpha=255,time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 2
	else
		animate(src,alpha=0,time=SECONDS_TO_DECISECONDS(speed))
		src.mouse_opacity = 0

/obj/hud/inventory/New(var/desired_loc)
	held_objects = list()
	worn_objects = list()
	. = ..()

/obj/hud/inventory/can_be_attacked(var/atom/attacker)
	return FALSE

/obj/hud/inventory/get_examine_text(var/atom/examiner)

	var/atom/A = get_top_held_object()

	if(!A)
		A = get_top_worn_object()

	if(A && A != src)
		return A.get_examine_text(examiner)
	else
		return ..()

/obj/hud/inventory/proc/update_overlays()

	for(var/O in overlays)
		qdel(O)

	overlays = list()

	var/total_pixel_x = 0
	var/total_pixel_y = 0

	for(var/obj/item/I in held_objects)
		I.pixel_x = x_offset_initial + total_pixel_x*TILE_SIZE
		I.pixel_y = y_offset_initial + total_pixel_y*TILE_SIZE

		if(x_offset_mul)
			total_pixel_x += I.size*x_offset_mul

		if(y_offset_mul)
			total_pixel_y += I.size*y_offset_mul

		overlays += I

	for(var/obj/item/I in worn_objects)
		I.pixel_x = x_offset_initial + total_pixel_x*TILE_SIZE
		I.pixel_y = y_offset_initial + total_pixel_y*TILE_SIZE

		if(x_offset_mul)
			total_pixel_x += I.size*x_offset_mul

		if(y_offset_mul)
			total_pixel_y += I.size*y_offset_mul

		overlays += I


/obj/hud/inventory/update_icon()

	if(parent_inventory)
		color = "#ff0000"
	else
		color = initial(color)

	update_overlays()

/obj/hud/inventory/proc/update_held_icon(var/obj/item/item_to_update)

	if(owner && item_to_update)
		owner.remove_overlay(item_to_update)
		if(id == BODY_HAND_LEFT)
			owner.add_overlay(item_to_update, desired_icon=initial(item_to_update.icon), desired_icon_state=item_to_update.icon_state_held_left, desired_layer = LAYER_MOB_HELD, desired_never_blend = TRUE)
		else if(id == BODY_HAND_RIGHT)
			owner.add_overlay(item_to_update, desired_icon=initial(item_to_update.icon), desired_icon_state=item_to_update.icon_state_held_right, desired_layer = LAYER_MOB_HELD, desired_never_blend = TRUE)

	return TRUE

/obj/hud/inventory/proc/update_owner(var/mob/desired_owner) //Can also be safely used as an updater.

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_inventory(src)

	owner = desired_owner

	if(owner)
		owner.add_inventory(src)

	return TRUE

/obj/hud/inventory/proc/add_object(var/obj/item/I,var/messages = TRUE) //Prioritize wearing it, then holding it.

	if(I.can_be_worn() && add_worn_object(I,messages))
		return TRUE

	if(I.can_be_held() && add_held_object(I,messages))
		return TRUE

	return FALSE

/obj/hud/inventory/proc/add_held_object(var/obj/item/I,var/messages = TRUE,var/bypass_checks = FALSE)

	if(!I)
		LOG_ERROR("Tried to add a null item to [src]!")
		return FALSE

	var/atom/old_location = I.loc

	if(!bypass_checks && !can_hold_object(I,messages))
		return FALSE

	if(is_inventory(I.loc))
		var/obj/hud/inventory/I2 = I.loc
		if(I2 == src)
			return FALSE
		I2.remove_object(I,get_turf(I))

	undelete(I)

	I.force_move(src)

	I.plane = PLANE_HUD_OBJ
	held_objects += I
	if(owner)
		I.update_owner(owner)
		owner.held_objects += I
		owner.update_slowdown_mul()
		update_held_icon(I)

	update_overlays()
	update_stats()

	I.on_pickup(old_location,src)

	return TRUE

/obj/hud/inventory/proc/add_worn_object(var/obj/item/I, var/messages = TRUE, var/bypass_checks = FALSE)

	if(!bypass_checks && !can_wear_object(I,messages))
		return FALSE

	for(var/obj/item/C in owner.worn_objects)
		if(C.item_slot & I.item_slot && (!C.ignore_other_slots && !I.ignore_other_slots))
			if(messages)
				owner.to_chat(span("notice","\The [C] prevents you from wearing \the [I]!"))
			return FALSE

	if(is_inventory(I.loc))
		var/obj/hud/inventory/I2 = I.loc
		if(I2 == src)
			return FALSE
		I2.remove_object(I,owner.loc)

	undelete(I)

	I.force_move(src)

	I.plane = PLANE_HUD_OBJ
	worn_objects += I
	update_overlays()
	update_stats()
	if(owner)
		I.update_owner(owner)
		owner.worn_objects += I
		owner.update_slowdown_mul()
		update_worn_icon(I)

	return TRUE

/obj/hud/inventory/proc/update_worn_icon(var/obj/item/item_to_update)

	var/desired_icon_state
	if(item_to_update.slot_icons)
		desired_icon_state = "[item_to_update.icon_state_worn]_[src.id]"
	else
		desired_icon_state = item_to_update.icon_state_worn

	owner.add_overlay(item_to_update,desired_layer = item_to_update.worn_layer,desired_icon_state = desired_icon_state,desired_no_initial = item_to_update.no_initial_blend)

/obj/hud/inventory/proc/drop_worn_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	for(var/obj/item/I in worn_objects)
		if(exclude_soulbound && I.soul_bound)
			continue
		if(remove_object(I,T))
			dropped_objects += I

	return dropped_objects

/obj/hud/inventory/proc/drop_held_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	for(var/obj/item/I in held_objects)
		if(exclude_soulbound && I.soul_bound)
			continue
		if(remove_object(I,T))
			dropped_objects += I

	return dropped_objects

/obj/hud/inventory/proc/delete_held_objects()
	for(var/obj/item/I in held_objects)
		remove_object(I,owner.loc)
		qdel(I)

/obj/hud/inventory/proc/delete_worn_objects()
	for(var/obj/item/I in worn_objects)
		remove_object(I,owner.loc)
		qdel(I)

/obj/hud/inventory/proc/drop_all_objects(var/turf/T,var/exclude_soulbound=FALSE)
	var/list/dropped_objects = list()
	dropped_objects += drop_held_objects(T)
	dropped_objects += drop_worn_objects(T)
	return dropped_objects

/obj/hud/inventory/proc/delete_all_objects()
	delete_held_objects()
	delete_worn_objects()

/obj/hud/inventory/proc/remove_all_objects()
	for(var/obj/item/I in worn_objects)
		qdel(remove_object(I))
	for(var/obj/item/I in held_objects)
		qdel(remove_object(I))

/obj/hud/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc) //Removes the object from both worn and held objects, just in case.

	var/was_removed = FALSE

	if(I in held_objects)
		held_objects -= I
		owner.held_objects -= I
		was_removed = TRUE

	if(I in worn_objects)
		worn_objects -= I
		owner.worn_objects -= I
		was_removed = TRUE

	if(was_removed)
		I.force_move(drop_loc ? drop_loc : get_turf(src.loc))
		I.plane = initial(I.plane)
		update_overlays()
		update_stats()
		owner.remove_overlay(I)
		queue_delete(I,600)
		I.on_drop(src,drop_loc)

	return I

/obj/hud/inventory/proc/update_stats()
	total_weight = 0
	total_size = 0

	for(var/obj/item/O in held_objects)
		total_weight += O.weight
		total_size += O.size

	if(length(held_objects))
		var/obj/item/I = get_top_held_object()
		name = I.name
	else if(length(worn_objects))
		var/obj/item/I = get_top_worn_object()
		name = I.name
	else
		name = initial(name)

	/* TODO: IMPORTANT, IS THIS NEEDED?
	if(owner)
		owner.update_icon()
	*/

/obj/hud/inventory/proc/can_hold_object(var/obj/item/I,var/messages = FALSE)

	if(I.delete_on_drop)
		return FALSE

	if(!I.can_be_held(owner,src))
		return FALSE

	if(parent_inventory)
		return FALSE

	if(held_slots <= 0)
		return FALSE

	if(length(item_blacklist))
		for(var/o in item_blacklist)
			if(istype(I,o))
				if(messages)
					owner.to_chat(span("notice","You can't seem to fit \the [I] in \the [src]!"))
				return FALSE

	if(length(item_whitelist))
		var/whitelist_found = FALSE
		for(var/o in item_whitelist)
			if(istype(I,o))
				whitelist_found = TRUE
				break

		if(!whitelist_found)
			if(messages)
				owner.to_chat(span("notice","You can't seem to fit \the [I] in \the [src]!"))
			return FALSE

	if(length(held_objects) >= held_slots)
		if(messages)
			owner.to_chat(span("notice","You don't see how you can fit any more objects in \the [src]."))
		return FALSE

	if(!(I.type in item_bypass) && !(src.type in I.inventory_bypass))
		if(total_size + I.size > max_size)
			if(messages)
				owner.to_chat(span("notice","\The [I] is too large to be put in \the [src]."))
			return FALSE

		if(total_weight + I.weight > max_weight)
			if(messages)
				owner.to_chat(span("notice","\The [I] is too heavy to be put in \the [src]."))
			return FALSE

	return TRUE

/obj/hud/inventory/proc/can_wear_object(var/obj/item/I,var/messages = FALSE)

	if(!I.can_be_worn(owner,src))
		return FALSE

	if(parent_inventory)
		return FALSE

	if(worn_slots <= 0)
		return FALSE

	if(is_clothing(I))
		var/obj/item/clothing/C = I
		if(C.flags_clothing && is_advanced(owner))
			var/mob/living/advanced/A = owner
			for(var/obj/item/organ/O in A.organs)
				if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_FEET && O.flags_organ & FLAG_ORGAN_BEAST_FEET)
					if(messages)
						owner.to_chat(span("notice","Beast races cannot wear this!"))
					return FALSE
				if(C.flags_clothing & FLAG_CLOTHING_NOBEAST_HEAD && O.flags_organ & FLAG_ORGAN_BEAST_HEAD)
					if(messages)
						owner.to_chat(span("notice","Beast races cannot wear this!"))
					return FALSE

	if(!(I.item_slot & item_slot))
		if(messages)
			owner.to_chat(span("notice","You cannot wear \the [I] like this!"))
		return FALSE

	if(length(worn_objects) >= worn_slots)
		if(messages)
			owner.to_chat(span("notice","You cannot seem to fit this on your already existing clothing!"))
		return FALSE

	return TRUE

/obj/hud/inventory/proc/get_top_worn_object()

	if(!length(worn_objects))
		return FALSE

	return worn_objects[length(worn_objects)]

/obj/hud/inventory/proc/get_top_held_object()
	if(!length(held_objects))
		return FALSE

	return held_objects[length(held_objects)]