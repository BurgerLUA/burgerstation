#define GLOBAL_CLICK_DELAY 							\
	var/true_time_of_day = true_time();				\
	if(next_global_click > true_time_of_day)		\
		return TRUE;								\
	next_global_click = true_time_of_day + 1;


/client/proc/get_click_flags(var/list/params,var/check_swap = FALSE)

	. = 0x0

	if(selected_hand)
		if(selected_hand == LEFT_HAND)
			. |= CLICK_RIGHT
		else
			. |= CLICK_LEFT
	else
		if((settings.loaded_data["swap_mouse"] && check_swap) ? ("left" in params) :("right" in params))
			. |= CLICK_RIGHT

		if((settings.loaded_data["swap_mouse"] && check_swap) ? ("right" in params) : ("left" in params))
			. |= CLICK_LEFT

	if("middle" in params)
		. |= CLICK_MIDDLE

/client/MouseWheel(var/atom/object,delta_x,delta_y,location,control,params)

	GLOBAL_CLICK_DELAY

	var/list/new_params = params2list(params)
	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

	if((mob.attack_flags & CONTROL_MOD_GRAB) && allow_zoom_controls)
		var/precise_zoom = mob.attack_flags & CONTROL_MOD_DISARM
		var/change_in_screen = clamp(delta_y,-1,1)
		if(precise_zoom)
			change_in_screen *= 0.1
		update_zoom(zoom_level + change_in_screen)
		return TRUE

	if(!object || !(object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
		return FALSE

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(!object || object.qdeleting)
		return FALSE

	mob.on_mouse_wheel(object,delta_x,delta_y,location,control,new_params)

	. = ..()

/client/Click(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)
	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

	var/click_flags = get_click_flags(new_params,TRUE)

	if(!object || !(object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
		return FALSE

	GLOBAL_CLICK_DELAY

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(!object || object.qdeleting)
		return FALSE

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

	. = ..()

/client/MouseDown(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)
	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(screen_loc)
		mouse_down_x = screen_loc[1]
		mouse_down_y = screen_loc[2]

	store_new_params(object,location,new_params)

	var/click_flags = get_click_flags(new_params,TRUE)
	if(examine_mode && (click_flags & CLICK_RIGHT) && (permissions & FLAG_PERMISSION_MODERATOR))
		debug_variables(object)
		return TRUE
	if(click_flags & CLICK_LEFT)
		mob.attack_flags |= CONTROL_MOD_LEFT
	if(click_flags & CLICK_RIGHT)
		mob.attack_flags |= CONTROL_MOD_RIGHT

	if(!object || (object.interaction_flags & FLAG_INTERACTION_CLICK) || object.qdeleting)
		return FALSE

	GLOBAL_CLICK_DELAY

	object = object.defer_click_on_object(mob,location,control,new_params)

	if(!object || object.qdeleting)
		return FALSE

	if(examine_mode)
		if(mob) mob.display_turf_contents(get_turf(object))
		examine(object)
		return TRUE

	drag_last = world.time

	if(click_flags & CLICK_LEFT)
		mob.on_left_down(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_down(object,location,control,new_params)

	if(click_flags & CLICK_MIDDLE)
		if(mob && mob.movement_flags & MOVEMENT_RUNNING && (is_turf(object) || is_turf(object.loc)))
			if(spam_protection_interact <= 10)
				var/turf/T = get_turf(mob)
				var/obj/effect/temp/arrow/A = new(get_turf(object))
				A.pixel_x = (T.x - A.x)*TILE_SIZE
				A.pixel_y = (T.y - A.y)*TILE_SIZE + TILE_SIZE
				A.desired_pixel_x = new_params[PARAM_ICON_X] - 16
				A.desired_pixel_y = new_params[PARAM_ICON_Y] - 16
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

	. = ..()

/client/MouseUp(var/atom/object,location,control,params)

	var/list/new_params = params2list(params)
	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

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

	if(!object || object.qdeleting)
		return FALSE

	if(click_flags & CLICK_LEFT)
		mob.on_left_up(object,location,control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_up(object,location,control,new_params)

	. = ..()

/client/MouseDrop(var/atom/src_object,var/atom/over_object,src_location,over_location,src_control,over_control,params)

	var/list/new_params = params2list(params)

	if(!src_object || !over_object || src_object.qdeleting || over_object.qdeleting)
		return FALSE

	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

	src_object = src_object.defer_click_on_object(mob,src_location,src_control,new_params)
	over_object = over_object.defer_click_on_object(mob,over_location,over_control,new_params)

	if(!src_object || !over_object || src_object.qdeleting || over_object.qdeleting)
		return FALSE

	if(src_object == over_object)
		return FALSE

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(!screen_loc || abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < 4)
		return FALSE

	if(!(src_object.interaction_flags & FLAG_INTERACTION_CLICK) && (world.time - drag_last < 5))
		return FALSE

	GLOBAL_CLICK_DELAY

	var/click_flags = get_click_flags(new_params,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,new_params)

	. = ..()


/client/MouseDrag(var/atom/src_object,var/atom/over_object,var/atom/src_location,var/atom/over_location,src_control,over_control,params)

	if(!src_object || !over_object || src_object.qdeleting || over_object.qdeleting)
		return FALSE

	MouseEntered(over_object,over_location,over_control,params) //God I hate this.

	var/list/new_params = params2list(params)

	var/list/screen_loc = parse_screen_loc(new_params["screen-loc"])
	if(!screen_loc || abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < 4)
		return FALSE

	. = ..()

/client/MouseEntered(object,location,control,params)

	var/list/new_params = params2list(params)
	new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
	new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

	store_new_params(object,location,new_params)

	if(istype(object,/atom/))
		var/atom/A = object
		mob.examine_overlay.maptext = "<center size='3'>[A.name]</center>"
		if(mob.examine_bar) mob.examine_bar.maptext = "[A.name]"
	else
		mob.examine_overlay.maptext = null
		if(mob.examine_bar) mob.examine_bar.maptext = null

	if(mob && isturf(location))
		if(zoom_held && (world.time - zoom_time) > 4)
			var/list/offsets = get_directional_offsets(mob,location)
			if(offsets[1] || offsets[2])
				is_zoomed = get_dir_advanced(mob,location)
				mob.set_dir(is_zoomed)
				update_camera_offset(offsets[1],offsets[2])
		if(is_living(mob))
			var/mob/living/L = mob
			if(L.intent == INTENT_HARM)
				if(!is_zoomed) mob.set_dir(get_dir_advanced(mob,location))
				for(var/k in mob.light_sprite_sources)
					var/obj/light_sprite/LS = k
					if(LS.icon_state != "cone")
						continue
					LS.set_dir(SOUTH)
					LS.transform = LS.get_base_transform()

	. = ..()

/client/proc/store_new_params(object,location,params)
	last_params = params
	last_object = object
	last_location = location
	return TRUE