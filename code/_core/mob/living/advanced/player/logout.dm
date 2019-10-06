/mob/living/advanced/player/proc/save_and_logout(var/desired_last_safe)

	if(save(desired_last_safe))
		client.make_ghost(get_turf(src))
		qdel(src)
		return TRUE

	return FALSE

/mob/living/advanced/player/proc/save_and_delete(var/desired_last_safe)

	if(save(desired_last_safe))
		qdel(src)
		return TRUE

	return FALSE

/mob/living/advanced/player/proc/save(var/desired_last_safe)

	var/savedata/client/mob/U = mobdata

	if(desired_last_safe)
		U.loaded_data["last_save"] = desired_last_safe

	U.save_current_character()

	return TRUE


/mob/living/advanced/player/Logout()

	var/area/A = get_area(src)

	if(A.safe && A.assoc_wishgranter)
		save_and_delete(A.assoc_wishgranter)
	else
		logout_time = curtime

	return ..()