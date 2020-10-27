/loot/trash_pile
	loot_table = list()
	chance_none = 25
	loot_count = 8

/loot/trash_pile/New()

	for(var/k in subtypesof(/obj/item)) //Is this a good idea? Probably not.
		var/obj/item/I = k
		var/value = initial(I.value)
		if(value <= 1)
			continue
		loot_table[k] = CEILING(100/value,1)

	return ..()

