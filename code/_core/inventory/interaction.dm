/obj/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(caller.attack_flags & ATTACK_THROW)
		caller.face_atom(object)
		return throw_item(caller.dir)

	else if (caller.attack_flags & ATTACK_DROP)
		return drop_item()

	object = object.defer_click_on_object() //Change the object we click on to possibly the object that the inventory is holding

	if(is_inventory(object)) //Give items to another inventory if we click on it.
		var/obj/inventory/I = object
		if(length(held_objects) && I.add_object(get_top_held_object()))
			return TRUE
		if(length(worn_objects) && I.add_object(get_top_worn_object()))
			return TRUE

	var/obj/O = src.defer_click_on_object()

	if(O != src)
		return O.click_on_object(caller,object,location,control,params)

	if(is_item(object)) //Take items from another inventory.
		if(is_inventory(object.loc))
			var/obj/inventory/I = object.loc
			if(!I.drag_to_take && add_object(object))
				return TRUE

		else if(add_object(object))
			return TRUE

	if(..(caller,object,location,control,params))
		return TRUE

	return src.attack(caller,object,params)

obj/inventory/drop_on_object(caller,var/atom/object)

	if(!object)
		return TRUE

	object = object.defer_click_on_object()

	if(is_inventory(object)) //Give items to another inventory if we drag it.
		var/obj/inventory/I = object
		if(length(held_objects) && I.add_object(get_top_held_object()))
			return TRUE
		if(length(worn_objects) && I.add_object(get_top_worn_object()))
			return TRUE

	var/obj/O = src.defer_click_on_object()
	if(O != src)
		return O.drop_on_object(caller,object)

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