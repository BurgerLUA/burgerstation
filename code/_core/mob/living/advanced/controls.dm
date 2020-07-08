//An up is after a press.
mob/living/advanced/on_left_up(var/atom/object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(src.attack_flags & ATTACK_BLOCK)

	else
		if(right_hand)
			right_hand.on_mouse_up(src,object,location,control,params)
			return TRUE

	return FALSE

//An up is after a press.
mob/living/advanced/on_right_up(var/atom/object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE

	if(src.attack_flags & ATTACK_BLOCK)

	else
		if(left_hand)
			left_hand.on_mouse_up(src,object,location,control,params)
			return TRUE

	return FALSE

//A down is just a press.
mob/living/advanced/on_left_down(var/atom/object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(quick_mode && !right_hand.get_top_held_object() && handle_quick(object,location,control,params))
		return TRUE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return TRUE

	if(src.attack_flags & ATTACK_BLOCK)
		return FALSE
	else if(right_hand)
		if(is_button(object))
			return object.clicked_on_by_object(src,right_hand,location,control,params)
		return right_hand.click_on_object(src,object,location,control,params)

	return FALSE


//A down is just a press.
mob/living/advanced/on_right_down(var/atom/object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(quick_mode && !left_hand.get_top_held_object() && handle_quick(object,location,control,params))
		return TRUE

	if(is_inventory(object)) //THIS IS VERY IMPORTANT
		return TRUE


	if(src.attack_flags & ATTACK_BLOCK)

	else if(left_hand)
		if(is_button(object))
			return object.clicked_on_by_object(src,left_hand,location,control,params)
		return left_hand.click_on_object(src,object,location,control,params)

	return FALSE


//A click is a press AND release.
mob/living/advanced/on_left_click(var/atom/object,location,control,params) //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(!is_inventory(object)) //THIS IS VERY IMPORTANT
		return FALSE


	if(src.attack_flags & ATTACK_BLOCK)

	else if(right_hand)
		return right_hand.click_on_object(src,object,location,control,params)


	return FALSE


//A click is a press AND release.
mob/living/advanced/on_right_click(var/atom/object,location,control,params)  //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(!is_inventory(object)) //THIS IS VERY IMPORTANT
		return TRUE

	if(src.attack_flags & ATTACK_BLOCK)

	else if(left_hand)
		return left_hand.click_on_object(src,object,location,control,params)

	return FALSE


/mob/living/advanced/on_left_drop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	. = ..()

	if(!.)
		return .

	if(src_object && over_object) src_object.drop_on_object(src,over_object,over_location,over_control,params)

	return .

/mob/living/advanced/on_right_drop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	. = ..()

	if(!.)
		return .

	if(src_object && over_object) src_object.drop_on_object(src,over_object,over_location,over_control,params)

	return .


mob/living/advanced/proc/handle_quick(var/atom/object,location,control,params)

	for(var/obj/hud/button/slot/B in buttons)
		if(B.id == quick_mode)
			if(!B.stored_atom && is_button(object))
				B.store_atom(src,object,location,control,params)
				break
			var/obj/item/I = B.stored_atom

			if(!istype(I)|| !I.quick_function_type == FLAG_QUICK_TOGGLE)
				break

			if(is_inventory(B.stored_atom.loc))
				var/obj/hud/inventory/I2 = B.stored_atom.loc
				if(I2.owner != src)
					B.clear_object(src)
					break
			else if(!is_button(B.stored_atom))
				B.clear_object(src)
				break

			B.stored_atom.quick(src,location,control,params)
			return TRUE

	return TRUE