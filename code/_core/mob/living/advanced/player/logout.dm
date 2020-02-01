mob/living/advanced/player/proc/can_save(var/area/A)
	if(!client)
		return FALSE

	if(!A || !(A.flags_area & FLAGS_AREA_SAVEZONE))
		return FALSE

	var/obj/structure/interactive/bed/sleeper/S = locate() in get_turf(src).contents
	return S && istype(S) && S.buckled

mob/living/advanced/player/verb/logout()

	set name = "Save and Quit"
	set desc = "Saves and quits your character, returning you to the main menu."
	set category = "Menu"

	if(!loc)
		return FALSE

	var/area/A = get_area(src)

	if(mobdata && mobdata.loaded_data && mobdata.loaded_data["tutorial"] == 1)
		var/question = input("Are you sure you want to quit? All unsaved progress will be lost.") in list("Yes","No")
		if(question == "Yes")
			make_ghost()
			return TRUE
	if(mobdata && mobdata.loaded_data && mobdata.loaded_data["tutorial"] == 2)
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes")
			save(null)
			make_ghost()
			return TRUE
	else if(can_save(A))
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && can_save(A))
			save()
			make_ghost()
			qdel(src)
			return TRUE
	else
		src.to_chat(span("danger","You cannot save and quit here! Find an area with a suitable wishgranter first!"))

	return FALSE


/mob/living/advanced/player/proc/make_ghost(var/turf/T)

	if(!T)
		T = get_turf(src)

	client.make_ghost(T)

	return TRUE

/mob/living/advanced/player/proc/save(var/save_inventory = TRUE)

	var/savedata/client/mob/U = mobdata


	U.save_current_character(save_inventory)

	return TRUE

/*
/mob/living/advanced/player/Logout()

	if(!qdeleting) //Only do this if you're not being deleted.

		logout_time = curtime

		if(loc)
			var/area/A = get_area(src)
			if(A.safe && A.assoc_wishgranter)
				save(A.assoc_wishgranter)
				qdel(src)

	return ..()
*/