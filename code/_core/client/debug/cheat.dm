/client/verb/learn_all_wishgranters()
	set category = "Debug"
	set name = "Learn all wishgranters"

	if(!is_advanced(src.mob))
		return FALSE

	var/mob/living/advanced/A = src.mob

	for(var/k in all_wishgranters)
		if(k in A.known_wishgranters)
			continue
		A.to_chat("Adding [k] to known wishgranters!")
		A.known_wishgranters += k


	return TRUE