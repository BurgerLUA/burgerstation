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

	if(can_save(A))
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && can_save(A))
			mobdata.save_current_character()
			client.make_ghost(get_turf(src))
			qdel(src)
			return TRUE

	return FALSE