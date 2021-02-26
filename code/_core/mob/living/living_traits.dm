/mob/living/proc/add_trait(var/trait_to_add)

	var/trait/T = TRAIT(trait_to_add)
	if(!T)
		log_error("tried adding a trait [trait_to_add], but it didn't exist.")
		return FALSE

	for(var/k in traits)
		var/trait/T2 = TRAIT(k)
		if(T2.category == T.category) //Cannot have trait that have the same category.
			traits -= T2.type
			T2.on_remove(src)

	traits[trait_to_add] = TRUE
	traits_by_category[T.category] = trait_to_add
	T.on_add(src)

	return TRUE

/mob/living/proc/remove_trait(var/trait_to_remove)
	if(!traits[trait_to_remove])
		return FALSE
	var/trait/T = TRAIT(trait_to_remove)
	if(!T)
		return FALSE
	traits -= trait_to_remove
	traits -= traits_by_category
	T.on_remove(src)
	return TRUE

/mob/living/proc/get_trait_by_category(var/desired_category)
	if(!traits_by_category[desired_category])
		return null
	return TRAIT(traits_by_category[desired_category])

/mob/living/proc/has_trait(var/trait_to_check)
	return traits[trait_to_check] ? TRUE : FALSE