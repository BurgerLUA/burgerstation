/loot/supply
	loot_table = list()

/loot/supply/New()

	var/list/possible = list()
	possible += subtypesof(/obj/item/clothing/back/storage)
	possible += subtypesof(/obj/item/clothing/belt/storage)
	possible += subtypesof(/obj/item/clothing/head/helmet)
	possible += subtypesof(/obj/item/clothing/overwear/armor)
	possible += subtypesof(/obj/item/weapon)
	possible += subtypesof(/obj/item/magazine)

	for(var/k in possible)
		var/obj/item/I = k
		var/value = initial(I.value)
		var/value_burgerbux = initial(I.value_burgerbux)
		if(value < 0)
			continue
		if(value_burgerbux > 0)
			continue
		loot_table[k] = max(10,sin(value*(90/500))*100)

	return ..()