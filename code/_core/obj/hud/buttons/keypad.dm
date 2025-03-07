/obj/hud/button/keypad
	name = "keypad"

	var/stored_keypad = 0

	flags_hud = FLAG_HUD_SPECIAL

	has_quick_function = FALSE

/obj/hud/button/keypad/close
	name = "close keypad"
	icon_state = "close_inventory"
	screen_loc = "CENTER+3,CENTER+2"

/obj/hud/button/keypad/close/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(activator))
		var/mob/living/advanced/player/P = activator
		P.set_device_unactive()


/obj/hud/button/keypad/top
	icon_state = "keypad_top"
	screen_loc = "CENTER+2,CENTER+2"
	maptext = "<p align='right'>Hello</p>"
	maptext_y = 22
	maptext_x = -2

/obj/hud/button/keypad/top/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(.)

		var/number_selected = -100

		switch(params[PARAM_ICON_X])
			if(1 to 10)
				number_selected = 1
			if(12 to 21)
				number_selected = 2
			if(23 to 32)
				number_selected = 3

		switch(params[PARAM_ICON_Y])
			if(12 to 21)
				number_selected *= 1
			if(1 to 10)
				number_selected += 3

		if(number_selected == -100) //-100 basically means do nothing.
			return TRUE

		if(stored_keypad >= 1000) //Don't do anything. Max size.
			return ..()

		stored_keypad = (stored_keypad*10) + number_selected

		if(stored_keypad)
			maptext = "<div align='right'>[stored_keypad]</div>"
		else
			maptext = null

		for(var/obj/hud/button/keypad/K in activator.buttons)
			K.stored_keypad = stored_keypad

/obj/hud/button/keypad/bottom
	icon_state = "keypad_bottom"
	screen_loc = "CENTER+2,CENTER+1"

/obj/hud/button/keypad/bottom/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(.)

		var/number_selected = -100 //-100 basically means do nothing

		switch(params[PARAM_ICON_X])
			if(1 to 10)
				number_selected = 7
			if(12 to 21)
				number_selected = 8
			if(23 to 32)
				number_selected = 9

		switch(params[PARAM_ICON_Y])
			if(22 to 32)
				number_selected *= 1
			if(11 to 20)
				if(number_selected == 7)
					number_selected = -1
				else if(number_selected == 8)
					number_selected = 0
				else if(number_selected == 9)
					number_selected = -2

		if(number_selected == -2)
			//Submit
			if(is_player(activator))
				var/mob/living/advanced/player/P = activator
				if(P.active_device)
					P.active_device.trigger(activator,src,-1,stored_keypad)
			return TRUE

		if(number_selected == -100)
			return TRUE

		if(stored_keypad > 999)
			return TRUE

		if(number_selected == -1)
			//Clear
			stored_keypad = 0
		else
			stored_keypad = (stored_keypad*10) + number_selected

		for(var/obj/hud/button/keypad/K in activator.buttons)
			K.stored_keypad = stored_keypad
			K.update_sprite()

	return .