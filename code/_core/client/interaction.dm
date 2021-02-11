/client/proc/get_click_flags(var/list/params,var/check_swap = FALSE)

	. = 0x0

	if((swap_mouse && check_swap) ? ("left" in params) :("right" in params))
		. |= CLICK_RIGHT

	if((swap_mouse && check_swap) ? ("right" in params) : ("left" in params))
		. |= CLICK_LEFT

	if("middle" in params)
		. |= CLICK_MIDDLE

	return .

/client/MouseWheel(var/atom/object,delta_x,delta_y,location,control,params)

	var/list/new_params = params2list(params)

	if((mob.attack_flags & CONTROL_MOD_GRAB) && allow_zoom_controls)
		var/change_in_screen = delta_y > 1 ? 1 : -1
		if(precise_zoom)
			change_in_screen *= 0.1
		update_zoom(zoom_level + change_in_screen)
		return TRUE

	if(!object)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)
	mob.on_mouse_wheel(object,delta_x,delta_y,location,control,new_params)

	return ..()

/client/Click(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)

	var/click_flags = get_click_flags(new_params,TRUE)

	if(!object || object.plane < PLANE_HUD)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(examine_mode)
		if(mob) mob.display_turf_contents(get_turf(object))
		examine(object)
		return TRUE

	if(click_flags & CLICK_LEFT)
		mob.on_left_click(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_click(object,location,control,new_params)

	if(click_flags & CLICK_MIDDLE)
		examine(object)

	return ..()

/client/MouseDown(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(screen_loc)
		mouse_down_x = screen_loc[1]
		mouse_down_y = screen_loc[2]

	store_new_params(object,location,new_params)

	var/click_flags = get_click_flags(new_params,TRUE)
	if(click_flags & CLICK_LEFT)
		mob.attack_flags |= CONTROL_MOD_LEFT
	if(click_flags & CLICK_RIGHT)
		mob.attack_flags |= CONTROL_MOD_RIGHT

	if(!object || object.plane >= PLANE_HUD)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(examine_mode)
		if(mob) mob.display_turf_contents(get_turf(object))
		examine(object)
		return TRUE

	if(click_flags & CLICK_LEFT)
		mob.on_left_down(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_down(object,location,control,new_params)

	if(click_flags & CLICK_MIDDLE)
		examine(object)

	return ..()

/client/MouseUp(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)

	var/click_flags = get_click_flags(new_params,TRUE)
	if(click_flags & CLICK_LEFT)
		mob.attack_flags &= ~CONTROL_MOD_LEFT
	if(click_flags & CLICK_RIGHT)
		mob.attack_flags &= ~CONTROL_MOD_RIGHT

	if(is_player(mob))
		var/mob/living/advanced/player/A = mob
		if(A.click_and_drag_icon)
			var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon
			click_and_drag_icon.stored_object = null
			click_and_drag_icon.stored_inventory = null
			click_and_drag_icon.alpha = 0

	if(!object || object.plane >= PLANE_HUD)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(click_flags & CLICK_LEFT)
		mob.on_left_up(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_up(object,location,control,new_params)

	return ..()

/client/MouseDrop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	var/list/new_params = params2list(params)

	if(!src_object || !over_object)
		return FALSE

	src_object = src_object.defer_click_on_object(mob,src_location,src_control,new_params)
	over_object = over_object.defer_click_on_object(mob,over_location,over_control,new_params)

	if(src_object == over_object)
		return FALSE

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(!screen_loc || abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.25)
		return FALSE

	var/click_flags = get_click_flags(new_params,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	return ..()


/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)

	var/list/new_params = params2list(params)

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(!screen_loc || abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.25)
		return FALSE

	store_new_params(over_object,over_location,new_params)

	return ..()

/client/proc/store_new_params(over_object,over_location,params)
	last_params = params
	last_object = over_object
	last_location = over_location
	return TRUE