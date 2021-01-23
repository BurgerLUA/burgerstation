/mob/living/verb/sneak()
	set name = "Toggle Sneak"
	set category = "Game"
	toggle_sneak(!is_sneaking)

/mob/living/verb/suicide()
	set name = "Suicide"
	set category = "Game"

	var/area/A = get_area(src)

	if(A.flags_area & FLAGS_AREA_TUTORIAL)
		var/question = input("Are you sure you want to cancel character creation? Your character won't be saved, and it will be deleted from the game.") in list("Yes","No")
		if(question == "Yes" && A.flags_area & FLAGS_AREA_TUTORIAL)
			client.make_ghost(get_turf(src))
			qdel(src)
			return TRUE
		return FALSE

	var/choice = input("Are you sure you want to kill yourself?","Suicide","Cancel") in list("Yes","No","Cancel")

	if(dead)
		to_chat(span("danger","You are already dead!"))
		return FALSE

	if(choice == "Yes")
		death()
		visible_message(span("danger","[src.name] kills themselves!"),span("danger","You kill yourself!"))
		suicide = TRUE
		client.make_ghost(get_turf(src))

/mob/living/verb/set_intent_harm()
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_HARM)

/mob/living/verb/set_intent_disarm()
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_DISARM)

/mob/living/verb/set_intent_grab()
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_GRAB)

/mob/living/verb/set_intent_help()
	set category = "Game"
	set hidden = TRUE
	set_intent(INTENT_HELP)

/mob/living/verb/cycle_intent_clockwise()
	set name = "Cycle Intent Clockwise"
	set category = "Game"

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