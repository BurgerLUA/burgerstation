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
	set hidden = TRUE
	set instant = TRUE
	var/is_focused = winget(src, "map.map", "focus") == "true"
	winset(src,"map.map","focus=[is_focused ? "false" : "true"]")
	winset(src,"control.input","focus=[is_focused ? "true" : "false"]")

/client/verb/focus_map()
	set hidden = TRUE
	set instant = TRUE
	winset(src,"map.map","focus=true")
	winset(src,"control.input","focus=false")

/client/verb/focus_input()
	set hidden = TRUE
	set instant = TRUE
	winset(src,"map.map","focus=false")
	winset(src,"control.input","focus=true")

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