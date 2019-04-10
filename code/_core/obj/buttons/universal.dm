/obj/button/drop
	name = "drop item"
	desc = "Drop the item in this slot."
	icon_state = "extension_left"
	screen_loc = "CENTER-1.5,BOTTOM"
	var/left = 0

/obj/button/drop/left
	icon_state = "extension_right"
	screen_loc = "CENTER+1.5,BOTTOM"
	left = 1

/obj/button/drop/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	var/mob/living/advanced/A = caller

	if(left)
		if(A.left_hand)
			A.left_hand.drop_held_objects(A.loc)

	else
		if(A.right_hand)
			A.right_hand.drop_held_objects(A.loc)

	return TRUE

/obj/button/resist
	name = "resist"
	desc = "DON'T FORGET TO SMASH THAT RESIST BUTTON."
	desc_extended = "Press this button if you want to resist out of whatever situation your in. (That doesn't mean that it will do it.)"
	icon_state = "resist"
	screen_loc = "RIGHT-3,BOTTOM"

/obj/button/resist/clicked_by_object(var/mob/caller,object,location,control,params)


	..()


/obj/button/resist_auto
	name = "toggle auto resist"
	desc = "For when you don't like clicking."
	desc_extended = "Automatically attempts to resist in some situations."
	icon_state = "auto"
	screen_loc = "RIGHT-3,BOTTOM"


/obj/button/resist_auto/update_icon()

	if(owner.auto_resist)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()

/obj/button/resist_auto/clicked_by_object(var/mob/caller,object,location,control,params)
	owner.auto_resist = !owner.auto_resist
	update_icon()
	..()

/obj/button/hide_show_inventory
	name = "toggle inventory"
	desc = "Need more space? Click this button."
	desc_extended = "Hides your inventory from view. Inventories such as pockets, belts, backpacks, and hands are not hidden."
	icon_state = "view_inventory"
	screen_loc = "LEFT,BOTTOM"

/obj/button/hide_show_inventory/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner
	A.toggle_inventory(FALSE,0.1)

	update_icon()
	..()

/obj/button/hide_show_inventory/update_icon()

	if(!is_advanced(owner))
		return ..()

	var/mob/living/advanced/A = owner


	if(A.draw_inventory)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_off"

	..()

/obj/button/sneak
	name = "sneak"
	desc = "sneaker no sneaking"
	desc_extended = "Press to sneak."
	icon_state = "sneak_0"
	screen_loc = "RIGHT-4,BOTTOM"

	var/sneaking = 0

/obj/button/sneak/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return

	var/mob/living/L = caller


	sneaking = !sneaking
	L.is_sneaking = sneaking
	update_icon()
	..()

/obj/button/sneak/update_icon()
	icon_state = "sneak_[sneaking]"
	..()

/obj/button/move
	name = "move"
	desc = "who fucking walks lmao"
	desc_extended = "Where you press determines where you click"
	icon_state = "move_1"
	screen_loc = "RIGHT-4,BOTTOM"

	var/move_mode = 2 //1 = run, 2 = jog, 3 = sprint

/obj/button/move/update_icon()
	icon_state = "move_[move_mode]"
	..()

/obj/button/move/clicked_by_object(var/mob/caller,object,location,control,params)

	if(params["icon-x"] && params["icon-y"] && text2num(params["icon-y"]) >= 10)

		switch(text2num(params["icon-x"]))
			if(1 to 10)
				caller.move_mod = 1
			if(12 to 21)
				caller.move_mod = 2
			if(23 to 32)
				caller.move_mod = 3
	else
		caller.move_mod += 1

	if(caller.move_mod > 3)
		caller.move_mod = 1

	move_mode = caller.move_mod

	update_icon()

	..()

/obj/button/targeting
	name = "limb targeting"
	desc = "aim for the head"
	desc_extended = "Where you press determines where you attack."
	icon_state = "targeting"
	screen_loc = "RIGHT,BOTTOM"

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

/obj/button/targeting/update_icon()

	icon = initial(icon)
	var/icon/base_icon = new /icon(icon,icon_state)

	var/list/chosen_left = left[mode]
	var/icon/left_overlay = new /icon(icon,"targeting_l")
	left_overlay.Shift(NORTH,0 + chosen_left[2] - 16)
	left_overlay.Shift(EAST,chosen_left[1] - 16 + 4)

	var/list/chosen_right = right[mode]
	var/icon/right_overlay = new /icon(icon,"targeting_r")
	right_overlay.Shift(NORTH,chosen_right[2] - 16)
	right_overlay.Shift(EAST,chosen_right[1] - 16 + 4)

	var/list/preset_overlay = new /icon(icon,"targeting_preset_[mode]")
	base_icon.Blend(preset_overlay,ICON_OVERLAY)
	base_icon.Blend(left_overlay,ICON_OVERLAY)
	base_icon.Blend(right_overlay,ICON_OVERLAY)

	icon = base_icon

	..()

/obj/button/targeting/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return

	if(!caller.client)
		return

	var/mob/living/L = caller

	var/click_flags = L.client.get_click_flags(params,TRUE)

	if(!(params["icon-x"] && params["icon-y"]))
		return

	var/x_click = text2num(params["icon-x"])
	var/y_click = text2num(params["icon-y"])

	if(x_click >= 10)
		if(click_flags & CLICK_LEFT)
			left[mode] = list(x_click - 5,y_click)
		if(click_flags & CLICK_RIGHT)
			right[mode] = list(x_click - 5,y_click)
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

	L.attack_mode = mode
	L.attack_right = right
	L.attack_left = left
	update_icon()
	..()

/obj/button/intent
	name = "intent"
	desc = "harm intent or bust"
	desc_extended = "Where you press determines where you attack."
	icon_state = "intent_help"
	screen_loc = "RIGHT-1,BOTTOM"

	var/help_intent = 1

/obj/button/intent/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!params["icon-y"])
		return

	var/y_click = text2num(params["icon-y"])

	if(y_click >= 16)
		help_intent = 1
	else
		help_intent = 0

	update_icon()
	..()

/obj/button/intent/update_icon()
	if(help_intent)
		icon_state = "intent_help"
	else
		icon_state = "intent_harm"
	..()

/obj/button/defense
	name = "defense toggles"
	desc = "turn all of them on, what could possibly go wrong"
	desc_extended = ""
	icon_state = "dpb_box"
	screen_loc = "RIGHT-2,BOTTOM"

	var/enable_dodge = 0
	var/enable_block = 1
	var/enable_parry = 0

/obj/button/defense/update_icon()

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

/obj/button/defense/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!params["icon-y"])
		return

	var/y_click = text2num(params["icon-y"])

	switch(y_click)
		if(21 to 32)
			enable_dodge = !enable_dodge
		if(11 to 20)
			enable_parry = !enable_parry
		if(1 to 10)
			enable_block = !enable_block

	update_icon()
	..()
