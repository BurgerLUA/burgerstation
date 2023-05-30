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

/loot/random/proc/get_base_types()
	return subtypesof(base_type)

/loot/random/proc/generate_loot_table()

	for(var/k in get_base_types())
		var/obj/item/I = k
		var/value = SSbalance.stored_value[k]
		if(value <= 0)
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


/loot/random/trash
	value_min = 1
	value_max = 100
	rarity_min = RARITY_BROKEN
	rarity_max = RARITY_COMMON

/loot/random/trash/get_base_types()
	return subtypesof(base_type) - subtypesof(/obj/item/bullet_cartridge/)

/loot/random/trash/lots
	loot_count = 20
	chance_none = 75

/loot/random/low
	value_min = 100
	value_max = 500
	rarity_min = RARITY_BROKEN
	rarity_max = RARITY_COMMON

/loot/random/low/lots
	loot_count = 10
	chance_none = 50

/loot/random/medium
	value_min = 500
	value_max = 1000
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_UNCOMMON

/loot/random/medium/lots
	loot_count = 5
	chance_none = 25

/loot/random/high
	value_min = 1000
	value_max = 2500
	loot_count = 2
	chance_none = 0
	rarity_min = RARITY_UNCOMMON
	rarity_max = RARITY_RARE

/loot/random/extreme
	value_min = 2500
	value_max = 5000
	loot_count = 1
	chance_none = 0
	rarity_min = RARITY_UNCOMMON
	rarity_max = RARITY_RARE

/loot/random/citizen
	value_min = 100
	value_max = 1000
	loot_count = 2
	chance_none = 20
	rarity_min = RARITY_COMMON
	rarity_max = RARITY_UNCOMMON
	size_max = SIZE_2

/loot/random/ashwalker
	value_min = 1
	value_max = 1000
	loot_count = 3
	chance_none = 10
	rarity_min = RARITY_UNCOMMON
	rarity_max = RARITY_RARE
	size_max = SIZE_2

/loot/random/ashwalker/high
	value_min = 1000
	value_max = 2000
	loot_count = 1
	chance_none = 0
	size_max = SIZE_3
