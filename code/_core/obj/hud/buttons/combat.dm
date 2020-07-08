/obj/hud/button/resist
	name = "resist"
	desc = "DON'T FORGET TO SMASH THAT RESIST BUTTON."
	desc_extended = "Press this button if you want to resist out of whatever situation your in. (That doesn't mean that it will do it.)"
	icon_state = "resist"
	screen_loc = "RIGHT-3:8,BOTTOM+1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/resist/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(. && is_living(owner))
		var/mob/living/L = owner
		L.resist()

	return .

/obj/hud/button/resist_auto
	name = "toggle auto resist"
	desc = "For when you don't like clicking."
	desc_extended = "Automatically attempts to resist in some situations."
	icon_state = "auto"
	screen_loc = "RIGHT-1,BOTTOM+1"

	flags = FLAGS_HUD_MOB

/obj/hud/button/resist_auto/update_icon()

	if(owner.auto_resist)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()

/obj/hud/button/resist_auto/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(.)
		owner.auto_resist = !owner.auto_resist
		update_sprite()

	return .

/*
/obj/hud/button/targeting
	name = "limb targeting"
	desc = "aim for the head"
	desc_extended = "Where you press determines where you attack."
	icon_state = "targeting"
	screen_loc = "RIGHT,BOTTOM"

	flags = FLAGS_HUD_MOB

	var/mode = 1

	var/list/left = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

	var/list/right = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

	user_colors = FALSE

/obj/hud/button/targeting/update_icon()

	icon = initial(icon)
	var/icon/base_icon = new /icon(icon,icon_state)

	var/list/chosen_left = left[mode]
	var/icon/left_overlay = new /icon(icon,"targeting_r")
	left_overlay.Shift(NORTH,0 + chosen_left[2] - 16 + 2)
	left_overlay.Shift(EAST,chosen_left[1] - 16 + 4)

	var/list/chosen_right = right[mode]
	var/icon/right_overlay = new /icon(icon,"targeting_l")
	right_overlay.Shift(NORTH,chosen_right[2] - 16 + 2)
	right_overlay.Shift(EAST,chosen_right[1] - 16 + 4)

	var/list/preset_overlay = new /icon(icon,"targeting_preset_[mode]")
	base_icon.Blend(preset_overlay,ICON_OVERLAY)
	swap_colors(base_icon)
	base_icon.Blend(left_overlay,ICON_OVERLAY)
	base_icon.Blend(right_overlay,ICON_OVERLAY)
	icon = base_icon

	..()

/obj/hud/button/targeting/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_player(caller))
		return

	if(!caller.client)
		return

	var/mob/living/advanced/player/P = caller

	var/click_flags = P.client.get_click_flags(params,TRUE)

	if(!(params[PARAM_ICON_X] && params[PARAM_ICON_Y]))
		return

	var/x_click = text2num(params[PARAM_ICON_X])
	var/y_click = text2num(params[PARAM_ICON_Y])

	if(x_click >= 10)
		if(click_flags & CLICK_LEFT)
			left[mode] = list(x_click - 4,y_click - 2)
		if(click_flags & CLICK_RIGHT)
			right[mode] = list(x_click - 4,y_click - 2)
	else
		switch(y_click)
			if(26 to 32)
				mode = 1
			if(18 to 24)
				mode = 2
			if(10 to 16)
				mode = 3
			if(2 to 8)
				mode = 4

	P.attack_mode = mode
	P.attack_right = right
	P.attack_left = left
	update_sprite()

	return ..()
*/

/*
/obj/hud/button/defense
	name = "defense toggles"
	desc = "turn all of them on, what could possibly go wrong"
	desc_extended = ""
	icon_state = "dpb_box"
	screen_loc = "RIGHT-2,BOTTOM+1"

	var/enable_dodge = 0
	var/enable_block = 1
	var/enable_parry = 0

	flags = FLAGS_HUD_MOB

/obj/hud/button/defense/update_icon()

	icon = initial(icon)

	var/icon/base_icon = new /icon(icon,icon_state)

	if(enable_dodge)
		var/icon/dodge = new /icon(icon,"dpb_dodge")
		base_icon.Blend(dodge,ICON_OVERLAY)

	if(enable_parry)
		var/icon/parry = new /icon(icon,"dpb_parry")
		base_icon.Blend(parry,ICON_OVERLAY)

	if(enable_block)
		var/icon/block = new /icon(icon,"dpb_block")
		base_icon.Blend(block,ICON_OVERLAY)


	icon = base_icon

	..()

/obj/hud/button/defense/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!params[PARAM_ICON_Y])
		return

	var/y_click = text2num(params[PARAM_ICON_Y])

	switch(y_click)
		if(21 to 32)
			enable_dodge = !enable_dodge
		if(11 to 20)
			enable_parry = !enable_parry
		if(1 to 10)
			enable_block = !enable_block

	update_sprite()

	return ..()
*/
