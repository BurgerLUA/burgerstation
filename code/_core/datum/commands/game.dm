/command/game/

/command/game/verb/cycle_intent_clockwise()
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


/command/game/verb/cycle_intent_counter_clockwise()
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
/command/game/verb/toggle_focus()
	set name = "Toggle Map Focus"
	set category = "Game"
	set hidden = TRUE
	var/is_focused = winget(src, "map.map", "focus") == "true"
	winset(src,"map.map","focus=[is_focused ? "false" : "true"]")
	winset(src,"main.input","focus=[is_focused ? "true" : "false"]")

/command/game/verb/focus_map()
	set name = "Focus Map"
	set category = "Game"
	set hidden = TRUE
	winset(src,"map.map","focus=true")
	winset(src,"main.input","focus=false")

/command/game/verb/focus_input()
	set name = "Focus Input"
	set category = "Game"
	set hidden = TRUE
	winset(src,"map.map","focus=false")
	winset(src,"main.input","focus=true")