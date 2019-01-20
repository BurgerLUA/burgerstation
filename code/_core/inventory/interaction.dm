/obj/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(caller.attack_flags & ATTACK_THROW) //Throw the object if we are telling it to throw.
		caller.face_atom(object)
		return throw_item(caller.dir)

	else if (caller.attack_flags & ATTACK_DROP) //Drop the object if we are telling it to drop.
		return drop_item()

	var/atom/the_hand = src.defer_click_on_object()
	var/atom/the_target = object.defer_click_on_object()

	if(the_hand == the_target && the_hand.click_self(caller))
		return TRUE

	if(is_inventory(the_hand) && is_item(the_target)) //We have an empty hand and the object we're clicking on is an item.
		var/obj/inventory/I = the_hand
		if(is_inventory(object)) //The target is actually inside the object, which is an inventory
			var/obj/inventory/I2 = object
			if(!I2.drag_to_take && add_object(the_target))
				return TRUE

		else if(I.add_object(the_target)) //The target is not inside an inventory.
			return TRUE

	else if(is_inventory(the_target) && is_item(the_hand))
		var/obj/inventory/I = the_target
		if(I.click_on_object(caller,the_hand,location,control,params))
			return TRUE

	if(is_item(the_hand))
		var/obj/item/O = the_hand
		if(O.click_on_object(caller,object,location,control,params))
			return TRUE

	if(is_mob(the_target) && the_hand.attack(caller,the_target,params))
		return TRUE

	return FALSE

obj/inventory/clicked_by_object(caller,object,location,control,params)
	if(is_inventory(object) && transfer_inventory_to_inventory(object))
		return TRUE

	return ..()

obj/inventory/proc/transfer_inventory_to_inventory(var/obj/inventory/I)
	if(length(held_objects) && I.add_object(get_top_held_object()))
		return TRUE
	if(length(worn_objects) && I.add_object(get_top_worn_object()))
		return TRUE

	return FALSE

obj/inventory/drop_on_object(caller,var/atom/object)

	if(!object)
		return TRUE

	var/atom/the_hand = src.defer_click_on_object()
	var/atom/the_target = object.defer_click_on_object()

	if(is_inventory(the_target) && transfer_inventory_to_inventory(the_target))
		return TRUE

	if(the_hand != src && the_hand.drop_on_object(caller,object))
		return TRUE

	return ..(caller,object)

/obj/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params)
	return src.loc

obj/inventory/defer_click_on_object()

	if(length(src.held_objects))
		return src.get_top_held_object()

	if(length(src.worn_objects))
		return src.get_top_worn_object()

	return src

obj/inventory/drop_item(var/turf/new_location)
	if(length(src.held_objects))
		return get_top_held_object().drop_item(new_location)
	else
		return FALSE