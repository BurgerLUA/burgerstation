mob/living/advanced/player/proc/can_save(var/area/A)

	if(!client)
		return FALSE

	if(!A || !(A.flags_area & FLAGS_AREA_SAVEZONE))
		src.to_chat(span("danger","You cannot save and quit here! Find a suitable zone to rest first!"))
		return FALSE

	var/obj/structure/interactive/bed/sleeper/S = locate() in src.loc.contents
	if(!S)
		src.to_chat(span("danger","Find a sleeper and lie down on it first!"))
		return FALSE

	if(!S.buckled)
		src.to_chat(span("danger","Lay down on the bed first!"))
		return FALSE

	return TRUE

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

		logout_time = world.time

		if(loc)
			var/area/A = get_area(src)
			if(A.safe && A.assoc_wishgranter)
				save(A.assoc_wishgranter)
				qdel(src)

	return ..()
*/