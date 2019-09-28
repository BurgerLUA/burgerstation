/obj/proc/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object
	return TRUE

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

/obj/proc/throw_item(var/direction)
	drop_item()
	set_dir(direction)
	//add_projectile(src)
	return TRUE

/obj/proc/transfer_item(var/obj/hud/inventory/new_inventory)

	if(new_inventory.held_slots >= 1)
		if(!new_inventory.can_hold_object(src,TRUE))
			return FALSE
	else if(new_inventory.worn_slots >= 1)
		if(!new_inventory.can_wear_object(src,TRUE))
			return FALSE

	drop_item()

	return new_inventory.add_object(src)
