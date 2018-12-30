//Inventory system. Basically anything that can hold an object needs an inventory.

/obj/inventory/
	name = "Inventory Holder"
	desc = "Inventory"
	//icon = 'icons/invisible.dmi'
	//icon_state = "0"

	icon = 'icons/hud/inventory.dmi'
	icon_state = "slot"

	var/list/obj/item/held_objects //Items that are held, and not worn.
	var/list/obj/item/clothing/worn_objects //Items that are worn, and not held.

	var/held_slots = 1 //How many items this object can hold.
	var/max_weight = -1 //Maximum weight this inventory object can hold.
	var/max_size = -1 //Maximum amount of size this object can hold.

	var/worn_slots = 1 //How many items this object can wear

	var/total_weight = 0 //Var storage value that is updated every time an item is changed.
	var/total_size = 0 //Var storage value that is updated every time an item is changed.


	var/item_slot = SLOT_NONE //Items that can be worn in this slot. Applies to clothing only.

	var/list/obj/item/item_blacklist = list() //Items that can't go in this invetory.
	var/list/obj/item/item_whitelist = list() //Items that can only go in this inventory.

	var/hud_icon //The HUD icon to spawn
	var/hud_icon_state //The HUD icon state to spawn
	var/hud_pixel_x = 0 //X Pixel Offset
	var/hud_pixel_y = 0 //Y Pixel Offset

	var/mob/owner //The mob that owns this object

	var/click_flags


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
	owner.add_inventory(src)

	return TRUE

/obj/inventory/proc/add_object(var/obj/item/I) //Prioritize wearing it, then holding it.
	if(is_clothing(I))
		var/obj/item/clothing/C = I
		if(add_worn_object(C))
			return TRUE

	return add_held_object(I)

/obj/inventory/proc/add_held_object(var/obj/item/I)
	if(!can_hold_object(I))
		return FALSE

	I.loc = src
	held_objects += I
	overlays += I
	update_stats()

	return TRUE

/obj/inventory/proc/add_worn_object(var/obj/item/clothing/C)
	if(!can_wear_object(C))
		return FALSE

	C.loc = src
	worn_objects += C
	overlays += C

	update_stats()

	return TRUE

/obj/inventory/proc/remove_object(var/obj/item/I,var/turf/drop_loc) //Removes the object from both worn and held objects, just in case.

	var/was_removed = FALSE

	if(I in held_objects)
		held_objects -= I
		was_removed = TRUE

	if(I in worn_objects)
		worn_objects -= I
		was_removed = TRUE

	if(was_removed)
		overlays -= I
		I.loc = drop_loc ? drop_loc : get_turf(src.loc)
		update_stats()

	return was_removed

/obj/inventory/proc/update_stats()
	total_weight = 0
	total_size = 0

	for(var/obj/item/O in held_objects)
		total_weight += O.weight
		total_size += O.size

	owner.update_icon()

/obj/inventory/proc/can_hold_object(var/obj/item/I)

	if(length(item_blacklist) && (I.type in item_blacklist))
		return FALSE

	if(length(item_whitelist) && !(I.type in item_whitelist))
		return FALSE

	if(length(held_objects) >= held_slots)
		return FALSE

	if(total_size + I.size > max_size)
		return FALSE

	if(total_weight + I.weight > max_weight)
		return FALSE

	return TRUE


/obj/inventory/proc/can_wear_object(var/obj/item/clothing/C)

	if(!(item_slot & C.item_slot))
		return FALSE

	if(length(worn_objects) >= worn_slots)
		return FALSE

	return TRUE


