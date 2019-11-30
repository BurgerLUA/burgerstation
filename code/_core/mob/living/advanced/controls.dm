//A down is just a press.
mob/living/advanced/on_left_up(object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			I.on_mouse_up(src,object,location,control,params)
			return TRUE

	return FALSE

//A down is just a press.
mob/living/advanced/on_right_up(object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.on_mouse_up(src,object,location,control,params)
			return TRUE

	return FALSE

//A down is just a press.
mob/living/advanced/on_left_down(object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(quick_mode && !right_hand.get_top_held_object())

		for(var/obj/hud/button/slot/B in buttons)
			if(B.id == quick_mode)
				if(!B.stored_item || !B.stored_item.quick_function_type == FLAG_QUICK_TOGGLE)
					break
				if(!is_inventory(B.stored_item.loc))
					B.clear_object(src)
					break
				var/obj/hud/inventory/I = B.stored_item.loc
				if(I.owner != src)
					B.clear_object(src)
					break
				B.stored_item.quick(src,location,control,params)
				return TRUE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			I.click_on_object(src,object,location,control,params)
			return TRUE

	return FALSE

//A down is just a press.
mob/living/advanced/on_right_down(object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(quick_mode && !left_hand.get_top_held_object())

		for(var/obj/hud/button/slot/B in buttons)
			if(B.id == quick_mode)
				if(!B.stored_item || !B.stored_item.quick_function_type == FLAG_QUICK_TOGGLE)
					break
				if(!is_inventory(B.stored_item.loc))
					B.clear_object(src)
					break
				var/obj/hud/inventory/I = B.stored_item.loc
				if(I.owner != src)
					B.clear_object(src)
					break
				B.stored_item.quick(src,location,control,params)
				return TRUE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.click_on_object(src,object,location,control,params)
			return TRUE

	return FALSE


//A click is a press AND release.
mob/living/advanced/on_right_click(object,location,control,params)  //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(!is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.click_on_object(src,object,location,control,params)
			return TRUE

	return FALSE

//A click is a press AND release.
mob/living/advanced/on_left_click(object,location,control,params) //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(!is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND && !(src.attack_flags & ATTACK_KICK)) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			I.click_on_object(src,object,location,control,params)
			return TRUE

	return FALSE

/mob/living/advanced/on_left_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)

	. = ..()

	if(!.)
		return .

	if(src_object) src_object.drop_on_object(src,over_object)

	return .

/mob/living/advanced/on_right_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)

	. = ..()

	if(!.)
		return .

	if(src_object) src_object.drop_on_object(src,over_object)

	return .

/mob/living/advanced/proc/get_left_hand()
	return left_hand && length(left_hand.held_objects) ? left_hand.held_objects[1] : null

/mob/living/advanced/proc/get_right_hand()
	return right_hand && length(right_hand.held_objects) ? right_hand.held_objects[1] : null