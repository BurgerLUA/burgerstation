/mob/living/verb/cycle_intent_clockwise()
	set name = "Cycle Intent Clockwise"
	set category = "Game"
	set hidden = TRUE

	switch(intent)
		if(INTENT_HELP)
			set_intent(INTENT_DISARM)
		if(INTENT_DISARM)
			set_intent(INTENT_GRAB)
		if(INTENT_GRAB)
			set_intent(INTENT_HARM)
		if(INTENT_HARM)
			set_intent(INTENT_HELP)

	for(var/obj/hud/button/intent/B in buttons)
		B.update_sprite()
		B.active = (B.intent == intent)
		B.update_overlays()


/mob/living/verb/cycle_intent_counter_clockwise()
	set name = "Cycle Intent Counter-Clockwise"
	set category = "Game"
	set hidden = TRUE

	switch(intent)
		if(INTENT_HELP)
			set_intent(INTENT_HARM)
		if(INTENT_DISARM)
			set_intent(INTENT_HELP)
		if(INTENT_GRAB)
			set_intent(INTENT_DISARM)
		if(INTENT_HARM)
			set_intent(INTENT_GRAB)

	for(var/obj/hud/button/intent/B in buttons)
		B.update_sprite()
		B.active = (B.intent == intent)
		B.update_overlays()


//For focusing.
/client/verb/toggle_focus()
	src << "This verb was activated."
	var/is_focused = winget(src, "map.map", "focus") == "true"
	winset(src,"map.map","focus=[is_focused ? "false" : "true"]")
	winset(src,"main.input","focus=[is_focused ? "true" : "false"]")

/client/verb/focus_map()
	winset(src,"map.map","focus=true")
	winset(src,"main.input","focus=false")

/client/verb/focus_input()
	winset(src,"map.map","focus=false")
	winset(src,"main.input","focus=true")


/client/verb/button_press(button as text)
	set hidden = TRUE
	set instant = TRUE
	if(!disable_controls)
		button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	set instant = TRUE
	if(!disable_controls)
		button_tracker.set_released(button)

/client/verb/change_click_mode()
	set name = "Swap Click Mode"
	set category = "Preferences"
	swap_mouse = !swap_mouse
	if(swap_mouse)
		to_chat(span("ui notice","Right clicking will now activate the object in your right hand, and vice versa."))
	else
		to_chat(span("ui notice","Left clicking will now activate the object in your right hand, and vice versa."))