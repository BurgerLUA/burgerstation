/*
/mob/living/verb/suicide()
	set category = "Game"
	set name = "Suicide"

	var/response = input("Are you sure you want to kill yourself?") in list("fuck go back","Yes")

	if(response == "Yes")
		death()
*/

/mob/living/verb/cycle_intent_clockwise()
	set name = "Cycle Intent Clockwise"
	set category = "Game"
	set hidden = TRUE

	switch(intent)
		if(INTENT_HELP)
			intent = INTENT_DISARM
		if(INTENT_DISARM)
			intent = INTENT_GRAB
		if(INTENT_GRAB)
			intent = INTENT_HARM
		if(INTENT_HARM)
			intent = INTENT_HELP

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
			intent = INTENT_HARM
		if(INTENT_DISARM)
			intent = INTENT_HELP
		if(INTENT_GRAB)
			intent = INTENT_DISARM
		if(INTENT_HARM)
			intent = INTENT_GRAB

	for(var/obj/hud/button/intent/B in buttons)
		B.update_sprite()
		B.active = (B.intent == intent)
		B.update_overlays()
