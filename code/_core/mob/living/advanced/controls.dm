
//A down is just a press.
mob/living/advanced/on_left_down(object,location,control,params)

	if(quick_mode)
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

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(is_inventory(object))
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			return I.click_on_object(src,object,location,control,params)

mob/living/advanced/on_right_down(object,location,control,params)

	if(driving)
		driving.click_on_object(src,object,location,control,params)
		return

	if(is_inventory(object))
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			I.click_on_object(src,object,location,control,params)

//A click is a press and release.
mob/living/advanced/on_left_click(var/atom/object,location,control,params)

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(!is_inventory(object))
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & RIGHT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & RIGHT_FOOT))
			return I.click_on_object(src,object,location,control,params)

mob/living/advanced/on_right_click(var/atom/object,location,control,params)

	if(driving)
		return driving.click_on_object(src,object,location,control,params)

	if(!is_inventory(object))
		return FALSE

	for(var/obj/hud/inventory/I in inventory)
		if((I.click_flags & LEFT_HAND) || (src.attack_flags & ATTACK_KICK && I.click_flags & LEFT_FOOT))
			return I.click_on_object(src,object,location,control,params)

/mob/living/advanced/on_left_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)
	if(src_object) src_object.drop_on_object(src,over_object)

/mob/living/advanced/on_right_drop(var/atom/src_object,over_object,src_location,over_location,src_control,over_control,aug)
	if(src_object) src_object.drop_on_object(src,over_object)

/mob/living/advanced/proc/get_left_hand()
	return left_hand && length(left_hand.held_objects) ? left_hand.held_objects[1] : null

/mob/living/advanced/proc/get_right_hand()
	return right_hand && length(right_hand.held_objects) ? right_hand.held_objects[1] : null

/mob/living/advanced/proc/do_automatic_left()
	if(automatic_left && client)
		return automatic_left.do_automatic(src,client.last_object,client.last_location,client.last_params)

	return FALSE

/mob/living/advanced/proc/do_automatic_right()
	if(automatic_right && client)
		return automatic_right.do_automatic(src,client.last_object,client.last_location,client.last_params)

	return FALSE
