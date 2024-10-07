/loot/random
	loot_table = list()
	chance_none = 0
	loot_count = 1

	var/value_min = 1
	var/value_max = 500

	var/rarity_min = RARITY_BROKEN
	var/rarity_max = RARITY_LEGENDARY

	var/size_max = SIZE_X

	var/base_type = /obj/item

	use_value = TRUE

	var/ignore_burgerbux = FALSE

	use_random_item_amounts = TRUE
	amount_mod_min = 0
	amount_mod_max = 1

/loot/random/proc/get_base_types()
	return subtypesof(base_type)

/loot/random/proc/generate_loot_table()

	for(var/k in get_base_types())
		var/obj/item/I = k
		var/value = SSbalance.stored_value[k]
		if(!value || value <= 0)
			continue
		if(value < value_min)
			continue
		if(value > value_max)
			continue
		var/initial_rarity = initial(I.rarity)
		if(rarity_to_number[initial_rarity] < rarity_to_number[rarity_min])
			continue
		if(rarity_to_number[initial_rarity] > rarity_to_number[rarity_max])
			continue
		if(!ignore_burgerbux && initial(I.value_burgerbux) > 0)
			continue
		if(initial(I.contraband))
			continue
		if(!initial(I.can_save))
			continue
		if(initial(I.size) > size_max)
			continue
		loot_table[I] = 1 //Correct multipliers added later.

	return TRUE


/loot/random/New()
	generate_loot_table()
	. = ..()
