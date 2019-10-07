mob/living/advanced/player/verb/logout()

	set name = "Save and Quit"
	set desc = "Saves and quits your character, returning you to the main menu."
	set category = "Menu"

	if(!loc)
		return FALSE

	var/area/A = get_area(src)

	if(A && A.safe && A.assoc_wishgranter && client)
		var/question = input("Are you sure you want to save and quit?") in list("Yes","No")
		if(question == "Yes" && A && A.safe && client)
			save(A.assoc_wishgranter)
			make_ghost()
			return TRUE

	return FALSE


/mob/living/advanced/player/proc/make_ghost(var/turf/T)

	if(!T)
		T = get_turf(src)

	world.log << "THE TURF IS: [T]"

	client.make_ghost(T)

	return TRUE

/mob/living/advanced/player/proc/save(var/desired_last_safe)

	var/savedata/client/mob/U = mobdata

	if(desired_last_safe)
		U.loaded_data["last_save"] = desired_last_safe

	U.save_current_character()

	return TRUE


/mob/living/advanced/player/Logout()

	if(!qdeleting) //Only do this if you're not being deleted.

		logout_time = curtime

		if(loc)
			var/area/A = get_area(src)
			if(A.safe && A.assoc_wishgranter)
				save(A.assoc_wishgranter)
				qdel(src)

	return ..()