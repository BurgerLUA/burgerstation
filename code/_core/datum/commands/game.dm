/mob/living/verb/set_intent_harm()
	set name = "Set Intent Harm"
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_HARM)

/mob/living/verb/set_intent_disarm()
	set name = "Set Intent Disarm"
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_DISARM)

/mob/living/verb/set_intent_grab()
	set name = "Set Intent Grab"
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_GRAB)

/mob/living/verb/set_intent_help()
	set name = "Set Intent Help"
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_HELP)

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
	if(settings && settings.loaded_data && settings.loaded_data["hud_colors"])
		var/color_scheme = settings.loaded_data["hud_colors"]
		var/dark = color_scheme[1]
		var/light = color_scheme[3]
		winset(src,"control.input","background-color=[is_focused ? light : dark]")

/client/verb/focus_map()
	set hidden = TRUE
	set instant = TRUE
	winset(src,"map.map","focus=true")
	winset(src,"control.input","focus=false")
	if(settings && settings.loaded_data && settings.loaded_data["hud_colors"])
		var/color_scheme = settings.loaded_data["hud_colors"]
		var/dark = color_scheme[1]
		winset(src,"control.input","background-color=[dark]")

/client/verb/focus_input()
	set hidden = TRUE
	set instant = TRUE
	winset(src,"map.map","focus=false")
	winset(src,"control.input","focus=true")
	if(settings && settings.loaded_data && settings.loaded_data["hud_colors"])
		var/color_scheme = settings.loaded_data["hud_colors"]
		var/light = color_scheme[3]
		winset(src,"control.input","background-color=[light]")

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