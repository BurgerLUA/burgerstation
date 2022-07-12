/loot/value
	loot_table = list()
	chance_none = 0
	loot_count = 1

	var/value_min = 1
	var/value_max = 500

/loot/value/New()

	for(var/k in subtypesof(/obj/item)) //Is this a good idea? Probably not.
		var/obj/item/I = k
		var/value = initial(I.value)
		if(value < value_min || value > value_max)
			continue
		var/value_burgerbux = initial(I.value_burgerbux)
		if(value_burgerbux > 0)
			continue
		loot_table[k] = CEILING(100/(value+1),1)

	return ..()


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
