/obj/item/clothing/belt/brass
	name = "brass belt"
	icon = 'icons/obj/item/clothing/belts/brass.dmi'
	desc = "PRAISE RATVAR!"
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed. This one is made of brass."

	is_container = TRUE

	dynamic_inventory_count = MAX_INVENTORY_X

	size = MAX_INVENTORY_X*SIZE_1

	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = 20,
		PIERCE = 20,
		ARCANE = 10,
		HEAT = -10,
		LASER = -10
	)

	rarity = RARITY_UNCOMMON

	value = 40

/obj/item/clothing/belt/brass/filled/fill_inventory()
	new /obj/item/weapon/melee/tool/brass/crowbar(src)
	new /obj/item/weapon/melee/tool/brass/multitool(src)
	new /obj/item/weapon/melee/tool/brass/welder(src)
	new /obj/item/weapon/melee/tool/brass/screwdriver(src)
	new /obj/item/weapon/melee/tool/brass/wirecutters(src)
	new /obj/item/weapon/melee/tool/brass/wrench(src)
	. = ..()