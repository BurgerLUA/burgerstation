/mob/living/proc/add_trait(var/trait_to_add)
	var/trait/T = TRAIT(trait_to_add)
	if(!T)
		return FALSE
	traits[trait_to_add] = TRUE
	T.on_add(src)
	return TRUE

/mob/living/proc/remove_trait(var/trait_to_remove)
	if(!traits[trait_to_remove])
		return FALSE
	var/trait/T = TRAIT(trait_to_remove)
	if(!T)
		return FALSE
	traits -= trait_to_remove
	T.on_remove(src)
	return TRUE