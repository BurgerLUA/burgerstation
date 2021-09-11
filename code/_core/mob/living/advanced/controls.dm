//An up is after a press.
mob/living/advanced/on_left_up(var/atom/object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(right_hand && right_hand.on_mouse_up(src,object,location,control,params))
		return TRUE

	return FALSE

//An up is after a press.
mob/living/advanced/on_right_up(var/atom/object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(left_hand && left_hand.on_mouse_up(src,object,location,control,params))
		return TRUE

	return FALSE

//A down is just a press.
mob/living/advanced/on_left_down(var/atom/object,location,control,params) //THIS ONLY WORKS ON NON-INVENTORIES.

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		if(driving.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,driving,location,control,params))
			return TRUE
		return FALSE

	if(right_hand)
		if(right_hand.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,right_hand,location,control,params))
			return TRUE

	return FALSE


//A down is just a press.
mob/living/advanced/on_right_down(var/atom/object,location,control,params)  //THIS ONLY WORKS ON NON-INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(driving)
		if(driving.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,driving,location,control,params))
			return TRUE
		return FALSE

	if(left_hand)
		if(left_hand.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,left_hand,location,control,params))
			return TRUE

	return FALSE


//A click is a press AND release.
mob/living/advanced/on_left_click(var/atom/object,location,control,params) //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(right_hand)
		if(right_hand.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,right_hand,location,control,params))
			return TRUE

	return FALSE


//A click is a press AND release.
mob/living/advanced/on_right_click(var/atom/object,location,control,params)  //THIS ONLY WORKS ON INVENTORIES

	if(!can_use_controls(object,location,control,params))
		return FALSE

	if(left_hand)
		if(left_hand.click_on_object(src,object,location,control,params))
			return TRUE
		if(object.clicked_on_by_object(src,left_hand,location,control,params))
			return TRUE

	return FALSE


/mob/living/advanced/on_left_drop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	if(!can_use_controls(src_object,src_location,src_control,params))
		return FALSE

	if(src_object && over_object)
		if(src_object.drop_on_object(src,over_object,over_location,over_control,params))
			return TRUE
		if(over_object.dropped_on_by_object(src,src_object,over_location,over_control,params))
			return TRUE

	return FALSE

/mob/living/advanced/on_right_drop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	if(!can_use_controls(src_object,src_location,src_control,params))
		return FALSE

	if(src_object && over_object)
		if(src_object.drop_on_object(src,over_object,over_location,over_control,params))
			return TRUE
		if(over_object.dropped_on_by_object(src,src_object,over_location,over_control,params))
			return TRUE

	return FALSE