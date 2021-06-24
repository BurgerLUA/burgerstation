/mob/living/proc/add_random_trait()

	var/trait/trait_to_add = pick(SStraits.all_traits)

	if(!trait_to_add || !add_trait(trait_to_add))
		log_error("Error! Could not add a trait via add_random_trait() to [src.get_debug_name()].")
		return FALSE

	return TRUE

/mob/living/proc/remove_random_trait()
	var/trait_to_remove = pick(traits)
	return remove_trait(trait_to_remove)

/mob/living/proc/remove_all_traits()

	for(var/k in traits)
		remove_trait(k)

	return TRUE

/mob/living/proc/add_trait(var/trait/trait_to_add,var/remove_existing_category=FALSE,var/messages=TRUE)

	var/trait/T = TRAIT(trait_to_add)
	if(!T)
		log_error("tried adding a trait [trait_to_add], but it didn't exist.")
		return FALSE

	if(!can_add_trait(T,remove_existing_category))
		return FALSE

	if(remove_existing_category)
		for(var/k in traits)
			var/trait/T2 = TRAIT(k)
			if(T2.category == T.category)
				traits -= T2.type
				T2.on_remove(src,messages)

	traits[trait_to_add] = TRUE
	traits_by_category[T.category] = trait_to_add
	T.on_add(src,messages)

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

/proc/get_trait_limit(rarity)

	switch(rarity)
		if(RARITY_COMMON)
			return 2
		if(RARITY_UNCOMMON)
			return 3
		if(RARITY_RARE)
			return 4
		if(RARITY_MYTHICAL)
			return 5
		if(RARITY_LEGENDARY)
			return 6

	return 0

/mob/living/proc/can_add_trait(var/trait/trait_to_add,var/remove_existing_category=FALSE) //Set to true if you want it to remove existing traits before adding the new one. False means it will fail to add if it finds a similar trait.

	if(!trait_to_add)
		return FALSE

	var/positive_traits = 0
	var/trait_limit = get_trait_limit(rarity) //Positive and Neutral traits

	if(!trait_limit)
		log_error("Error: [src.get_debug_name()] didn't have a valid rarity ([rarity])!")
		return FALSE

	for(var/k in traits)
		var/trait/T = TRAIT(k)
		if(!remove_existing_category && T.category == trait_to_add.category)
			return FALSE
		if(T.trait_tag == TRAIT_POSITIVE || T.trait_tag == TRAIT_NEUTRAL)
			positive_traits++
			if(positive_traits >= trait_limit)
				return FALSE

	return TRUE