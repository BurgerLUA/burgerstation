/loot/value
	loot_table = list()
	chance_none = 0
	loot_count = 1

	var/value_min = 1
	var/value_max = 500

	use_value = TRUE

/loot/value/New()

	for(var/k in SSbalance.stored_value)
		var/obj/item/I = k
		var/value = SSbalance.stored_value[k]
		if(value < value_min)
			continue
		if(value > value_max)
			continue
		if(initial(I.contraband))
			continue
		if(initial(I.value_burgerbux))
			continue
		loot_table[I] = 1 //Correct multipliers added later.

	. = ..()


/loot/value/trash
	value_min = 1
	value_max = 250
	loot_count = 20
	chance_none = 75

/loot/value/low
	value_min = 1
	value_max = 500
	loot_count = 10
	chance_none = 50

/loot/value/medium
	value_min = 500
	value_max = 1000
	loot_count = 5
	chance_none = 25

/loot/value/high
	value_min = 1000
	value_max = 2500
	loot_count = 2
	chance_none = 0

/loot/value/extreme
	value_min = 2500
	value_max = 5000
	loot_count = 1
	chance_none = 0


/loot/random_value
	loot_table = list(
		/loot/value/low = 1000,
		/loot/value/medium = 100,
		/loot/value/high = 10,
		/loot/value/extreme = 1
	)
	chance_none = 25

