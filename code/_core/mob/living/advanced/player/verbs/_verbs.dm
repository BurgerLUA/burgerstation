/mob/living/advanced/player/add_inherent_verbs()
	verbs += /mob/living/advanced/player/verb/logout
	return ..()

/mob/living/advanced/player/verb/logout()
	set name = "Save and Quit"
	set desc = "Saves and quits your character, returning you to the main menu."
	set category = "Menu"

	var/savedata/client/mob/mobdata = MOBDATA(ckey_last)

	if(!loc || !client || !mobdata)
		return FALSE

	var/area/A = get_area(src)

	if(world_state != STATE_RUNNING)
		src.to_chat(span("warning","You can't logout now! The game isn't running!"))
		return FALSE

	if(world_state == STATE_ROUND_END)
		src.to_chat(span("warning","You can't logout now, the round has already ended!"))
		return FALSE

	if(A.flags_area & FLAGS_AREA_TUTORIAL)
		var/question = input("Are you sure you want to cancel character creation? Your character won't be saved, and it will be deleted from the game.") in list("Yes","No")
		if(question == "Yes" && A.flags_area & FLAGS_AREA_TUTORIAL)
			client.make_ghost(get_turf(src))
			qdel(src)
			return TRUE
	else if(can_save(A))
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && can_save(A))
			force_logout()
			return TRUE

	return FALSE


