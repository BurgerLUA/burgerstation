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

	var/choice = input("Are you sure you want to kill yourself? This will make you unrevivable.","Suicide","Cancel") in list("Yes","No","Cancel")

	if(dead)
		to_chat(span("danger","You are already dead!"))
		return FALSE

	if(choice == "Yes")
		death(TRUE)
		visible_message(span("danger","[src.name] kills themselves!"),span("danger","You kill yourself!"))
		suicide = TRUE
		client.make_ghost(get_turf(src))

/mob/living/verb/set_intent_harm()
	set category = "Game"
	set hidden = TRUE
	selected_intent = INTENT_HARM
	update_intent()

/mob/living/verb/set_intent_disarm()
	set category = "Game"
	set hidden = TRUE
	selected_intent = INTENT_DISARM
	update_intent()

/mob/living/verb/set_intent_grab()
	set category = "Game"
	set hidden = TRUE
	selected_intent = INTENT_GRAB
	update_intent()

/mob/living/verb/set_intent_help()
	set category = "Game"
	set hidden = TRUE
	selected_intent = INTENT_HELP
	update_intent()

/mob/living/verb/cycle_intent_clockwise()
	set name = "Cycle Intent Clockwise"
	set category = "Game"

	switch(selected_intent)
		if(INTENT_HELP)
			selected_intent = INTENT_DISARM
		if(INTENT_DISARM)
			selected_intent = INTENT_GRAB
		if(INTENT_GRAB)
			selected_intent = INTENT_HARM
		if(INTENT_HARM)
			selected_intent = INTENT_HELP

	update_intent()

/mob/living/verb/cycle_intent_counter_clockwise()
	set name = "Cycle Intent Counter-Clockwise"
	set category = "Game"

	switch(selected_intent)
		if(INTENT_HELP)
			selected_intent = INTENT_HARM
		if(INTENT_DISARM)
			selected_intent = INTENT_HELP
		if(INTENT_GRAB)
			selected_intent = INTENT_DISARM
		if(INTENT_HARM)
			selected_intent = INTENT_GRAB

	update_intent()

