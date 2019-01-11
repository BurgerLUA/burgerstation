//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	id = "other"
	//icon = 'icons/invisible.dmi'
	//icon_state = "0"

	icon = 'icons/hud/inventory.dmi'
	icon_state = "slot"

	plane = 3

	var/list/obj/item/held_objects //Items that are held, and not worn.
	var/list/obj/item/clothing/worn_objects //Items that are worn, and not held.

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

	var/mob/owner //The mob that owns this object

	var/click_flags

	var/should_draw = TRUE //Should the item's held icon be displayed?
	var/reverse_draw = FALSE //Should the worn state and the held state be swapped?

/obj/inventory/New(var/desired_loc)
	loc = desired_loc

	held_objects = list()
	worn_objects = list()
	. = ..()

/obj/inventory/proc/update_owner(var/mob/desired_owner) //Can also be safely used as an updater.

	if(owner == desired_owner)
		return FALSE

	if(owner)
		owner.remove_inventory(src)

	owner = desired_owner

	if(owner)
		owner.add_inventory(src)

	return TRUE

/obj/inventory/proc/add_object(var/obj/item/I) //Prioritize wearing it, then holding it.
	if(I.can_be_worn())
		var/obj/item/clothing/C = I
		if(add_worn_object(C))
			return TRUE

	return add_held_object(I)

/obj/inventory/proc/add_held_object(var/obj/item/I,var/messages = TRUE)
	if(!can_hold_object(I,messages))
		return FALSE

	I.plane = 3
	I.loc = src
	held_objects += I
	overlays += I
	update_stats()

	return TRUE

/obj/inventory/proc/add_worn_object(var/obj/item/I, var/messages = TRUE)
	if(!can_wear_object(I,messages))
		return FALSE

	for(var/obj/item/C in owner.worn_objects)
		if(C.item_slot & I.item_slot)
			if(messages)
				to_chat(owner,span("notice","\The [C] prevents you from wearing \the [I]!"))
			return FALSE

	I.plane = 3
	I.loc = src
	worn_objects += I
	owner.worn_objects += I
	overlays += I

	I.update_owner(owner)

	update_stats()

	return TRUE

/obj/inventory/proc/remove_all_objects()
	for(var/obj/item/I in worn_objects)
		del(remove_object(I))
	for(var/obj/item/I in held_objects)
		del(remove_object(I))

/obj/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc) //Removes the object from both worn and held objects, just in case.

	var/was_removed = FALSE

	if(I in held_objects)
		held_objects -= I
		was_removed = TRUE

	if(I in worn_objects)
		worn_objects -= I
		owner.worn_objects -= I
		I.update_owner()
		was_removed = TRUE

	if(was_removed)
		overlays -= I
		I.plane = initial(I.plane)
		I.loc = drop_loc ? drop_loc : get_turf(src.loc)
		update_stats()

	return I

/obj/inventory/proc/update_stats()
	total_weight = 0
	total_size = 0

	for(var/obj/item/O in held_objects)
		total_weight += O.weight
		total_size += O.size

	if(length(held_objects))
		name = get_top_held_object().name
	else if(length(worn_objects))
		name = get_top_worn_object().name
	else
		name = initial(name)

	owner.update_icon()

/obj/inventory/proc/can_hold_object(var/obj/item/I,var/messages = FALSE)

	if(held_slots <= 0)
		return FALSE

	if(length(item_blacklist) && (I.type in item_blacklist))
		if(messages)
			owner.to_chat(span("notice","You can't seem to fit \the [I] in \the [src]!"))
		return FALSE

	if(length(item_whitelist) && !(I.type in item_whitelist))
		if(messages)
			owner.to_chat(span("notice","You can't seem to fit \the [I] in \the [src]!"))
		return FALSE

	if(length(held_objects) >= held_slots)
		if(messages)
			owner.to_chat(span("notice","You don't see how you can fit any more objects in \the [src]."))
		return FALSE

	if(total_size + I.size > max_size)
		if(messages)
			owner.to_chat(span("notice","\The [I] is too large to be put in \the [src]."))
		return FALSE

	if(total_weight + I.weight > max_weight)
		if(messages)
			owner.to_chat(span("notice","\The [I] is too heavy to be put in \the [src]."))
		return FALSE

	return TRUE

/obj/inventory/proc/can_wear_object(var/obj/item/I,var/messages = FALSE)

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

/obj/inventory/proc/get_top_worn_object()
	if(!length(worn_objects))
		return FALSE

	return worn_objects[length(worn_objects)]



/obj/inventory/proc/get_top_held_object()
	if(!length(held_objects))
		return FALSE

	return held_objects[length(held_objects)]
