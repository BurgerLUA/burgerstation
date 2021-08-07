/client/proc/get_click_flags(var/list/params,var/check_swap = FALSE)

	. = 0x0

	if((settings.loaded_data["swap_mouse"] && check_swap) ? ("left" in params) :("right" in params))
		. |= CLICK_RIGHT

	if((settings.loaded_data["swap_mouse"] && check_swap) ? ("right" in params) : ("left" in params))
		. |= CLICK_LEFT

	if("middle" in params)
		. |= CLICK_MIDDLE

/client/MouseWheel(var/atom/object,delta_x,delta_y,location,control,params)

	var/list/new_params = params2list(params)

	if((mob.attack_flags & CONTROL_MOD_GRAB) && allow_zoom_controls)
		var/precise_zoom = mob.attack_flags & CONTROL_MOD_DISARM
		var/change_in_screen = clamp(delta_y,-1,1)
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

	if(!object || !(object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(examine_mode)
		mob.display_turf_contents(get_turf(object))
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

	if(!object || (object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
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
		if(mob && mob.movement_flags & MOVEMENT_RUNNING && (isturf(object) || isturf(object.loc)))
			if(spam_protection_interact <= 10)
				var/obj/effect/temp/arrow/A = new(get_turf(object))
				A.pixel_x = text2num(new_params[PARAM_ICON_X]) - 16
				A.pixel_y = text2num(new_params[PARAM_ICON_Y]) - 16
				A.invisibility = mob.invisibility
				INITIALIZE(A)
				FINALIZE(A)
				mob.visible_message("<b>\The [mob.name]</b> points to <b>\the [object.name]</b>.")
				spam_protection_interact += 10
		else if(is_advanced(mob) && mob.attack_flags & CONTROL_MOD_GRAB && is_advanced(object))
			var/mob/living/advanced/A = object
			A.examine_body_inventory(mob)
		else
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

	if(!object || (object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(click_flags & CLICK_LEFT)
		mob.on_left_up(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_up(object,location,control,new_params)

	return ..()

/client/MouseDrop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	var/list/new_params = params2list(params)

	if(!src_object || !over_object || src_object.qdeleting || over_object.qdeleting)
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


/client/MouseDrag(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	if(!src_object || !over_object || src_object.qdeleting || over_object.qdeleting)
		return FALSE

	MouseEntered(over_object,over_location,over_control,params) //God I hate this.

	var/list/new_params = params2list(params)

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(!screen_loc || abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.25)
		return ..()

	. = ..()

/client/MouseEntered(object,location,control,params)

	var/list/new_params = params2list(params)

	store_new_params(object,location,new_params)

	if(!mob)
		return ..()

	if(object)
		mob.examine_overlay.maptext = "<center size='3'>[object]</center>"
	else
		mob.examine_overlay.maptext = null

	if(zoom_held && mob && isturf(location) && (world.time - zoom_time) > 4)
		var/real_angle = get_angle(mob,location) + 90
		var/desired_x_offset = sin(real_angle)
		var/desired_y_offset = cos(real_angle)
		var/real_dir = angle2dir(real_angle)
		is_zoomed = real_dir
		mob.set_dir(real_dir)
		update_camera_offset(desired_x_offset,desired_y_offset)

	. = ..()

/client/proc/store_new_params(object,location,params)
	last_params = params
	last_object = object
	last_location = location
	return TRUE