/obj/proc/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	var/atom/defer_self = src.defer_click_on_object()
	var/atom/defer_object = object.defer_click_on_object()

	if(object.clicked_by_object(caller,defer_self,location,control,params))
		return TRUE

	if(defer_self.attack(caller,defer_object,params)) //Attack the object, I guess.
		return TRUE

	return FALSE

/obj/proc/get_held()
	if(is_held())
		var/obj/hud/inventory/I = src.loc
		return I

	return null

/obj/proc/is_held()
	return istype(src.loc,/obj/hud/inventory)

/obj/proc/drop_item(var/turf/new_location)
	if(is_inventory(src.loc))
		var/obj/hud/inventory/I = src.loc
		if(!new_location)
			new_location = get_turf(I.owner)
		return I.remove_object(src,new_location)

	return FALSE

/obj/proc/transfer_item(var/obj/hud/inventory/new_inventory)

	if(new_inventory.held_slots >= 1)
		if(!new_inventory.can_hold_object(src,TRUE))
			return FALSE
	else if(new_inventory.worn_slots >= 1)
		if(!new_inventory.can_wear_object(src,TRUE))
			return FALSE

	drop_item()

	return new_inventory.add_object(src)
