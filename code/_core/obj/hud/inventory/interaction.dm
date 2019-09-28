/obj/hud/inventory/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(caller.attack_flags & ATTACK_THROW) //Throw the object if we are telling it to throw.
		caller.face_atom(object)
		var/atom/movable/object_to_throw = src.defer_click_on_object()
		if(is_item(object_to_throw))
			var/obj/item/I = object_to_throw
			var/vel_x = object.x - caller.x
			var/vel_y = object.y - caller.y
			var/highest = max(abs(vel_x),abs(vel_y))

			vel_x *= 1/highest
			vel_y *= 1/highest

			vel_x *= 28
			vel_y *= 28

			I.drop_item(get_turf(caller))
			//I.throw_self(caller,get_turf(object),params[PARAM_ICON_X],params[PARAM_ICON_Y],vel_x,vel_y)
			caller.throw_self(caller,get_turf(object),params[PARAM_ICON_X],params[PARAM_ICON_Y],vel_x,vel_y)

		return TRUE
	else if(caller.attack_flags & ATTACK_DROP) //Drop the object if we are telling it to drop.
		return drop_item()
	else if(grabbed_object && grabbed_object == object)
		return release_object(caller,object,location,control,params)
	else if(object && caller.attack_flags & ATTACK_GRAB && get_dist(caller,object) <= 1)
		return grab_object(caller,object,location,control,params)

	var/atom/the_hand = src.defer_click_on_object()
	var/atom/the_target = object.defer_click_on_object()

	if((caller.attack_flags & ATTACK_SELF || the_hand == the_target) && the_hand.click_self(caller))
		return TRUE

	if(is_movable(the_target))
		var/atom/movable/A = the_target
		if(!A.anchored)
			if(is_inventory(the_hand) && is_item(the_target) && get_dist(caller,the_target) <= 1) //We have an empty hand and the object we're clicking on is an item and we're next to it or we have it in our inventory.
				var/obj/item/target_item = the_target
				var/obj/hud/inventory/I = the_hand
				if(is_inventory(object)) //The thing we're clicking on is actually inside the object, which is an inventory

					var/obj/hud/inventory/I2 = object //Object = What we're clicking on
					if(target_item && target_item.on_inventory_click(caller,location,control,params))
						return TRUE

					if(!I2.drag_to_take && target_item.transfer_item(I2))
						return TRUE

				else if(target_item.transfer_item(I)) //The thing we're clicking on is not inside an inventory, so we're going to TAKE IT.
					return TRUE

			else if(is_inventory(the_target) && is_item(the_hand)) //We want to move the item we're holding to the thing we're clicking on.
				var/obj/item/I = the_hand
				var/obj/hud/inventory/I2 = the_target
				I.transfer_item(I2)
				return TRUE

	if(the_target.clicked_by_object(caller,the_hand,location,control,params)) //We click on the target
		return TRUE

	if(is_item(the_hand))
		var/obj/item/O = the_hand
		if(O.click_on_object(caller,object,location,control,params))
			return TRUE

	if(the_hand && the_hand.attack(caller,the_target,params))
		return TRUE

	return FALSE

obj/hud/inventory/clicked_by_object(caller,object,location,control,params)
	if(is_inventory(object) && transfer_inventory_to_inventory(object))
		return TRUE
	return ..()

obj/hud/inventory/proc/transfer_inventory_to_inventory(var/obj/hud/inventory/I)
	var/obj/item/O = get_top_held_object() || get_top_worn_object()
	return O && O.transfer_item(I)

obj/hud/inventory/drop_on_object(caller,var/atom/object)

	if(!object)
		return TRUE

	var/atom/the_hand = src.defer_click_on_object()
	var/atom/the_target = object.defer_click_on_object()

	if(is_inventory(the_target) && transfer_inventory_to_inventory(the_target)) //When we drop the src on the target, and the target is an inventory and we can transfer it.
		return TRUE

	if(is_item(the_target) && is_item(the_hand))
		var/obj/item/I1 = the_hand
		var/obj/item/I2 = the_target
		if(I2.is_container)
			I2.add_to_inventory(caller,I1)
			return TRUE

	if(the_hand != src && the_hand.drop_on_object(caller,object))
		return TRUE

	return ..(caller,object)

/obj/hud/inventory/get_object_to_damage_with(var/atom/attacker,var/atom/victim,params)
	return src.loc

obj/hud/inventory/drop_item(var/turf/new_location)
	if(length(src.held_objects))
		return get_top_held_object().drop_item(new_location)
	else
		return FALSE

/obj/hud/inventory/defer_click_on_object()

	if(!is_dynamic_inventory(src) || held_slots <= 1 && worn_slots <= 1)
		if(length(held_objects))
			return get_top_held_object()

		if(length(worn_objects))
			return get_top_worn_object()


	return src

/*
/obj/hud/inventory/get_examine_text(var/mob/examiner)
	. = ..()

	var/list/held_names = list()
	var/list/worn_names = list()

	for(var/obj/item/I in held_objects)
		held_names += I.name

	for(var/obj/item/I in worn_objects)
		worn_names += I.name

	if(length(worn_names))
		. +=

	if(length(held_names))
		. +=


	return .
*/