/obj/item/clothing/belt/storage
	name = "utility belt"
	icon = 'icons/obj/item/clothing/belts/tool.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."

	is_container = TRUE

	dynamic_inventory_count = MAX_INVENTORY_X

	size = MAX_INVENTORY_X*SIZE_1

	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = AP_SWORD,
		PIERCE = AP_SWORD
	)

	rarity = RARITY_UNCOMMON

	value = 40

/obj/item/clothing/belt/storage/tool/filled/fill_inventory()
	new /obj/item/weapon/melee/tool/crowbar(src)
	new /obj/item/weapon/melee/tool/multitool(src)
	new /obj/item/weapon/melee/tool/pickaxe(src)
	new /obj/item/weapon/melee/tool/screwdriver(src)
	new /obj/item/weapon/melee/tool/wirecutters(src)
	new /obj/item/weapon/melee/tool/wrench(src)
	return ..()

/obj/item/clothing/belt/storage/medical
	name = "medical belt"
	icon = 'icons/obj/item/clothing/belts/medical.dmi'
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed. This one is medical themed."

/obj/item/clothing/belt/storage/medical/filled/fill_inventory()
	new /obj/item/container/beaker/bottle/bicaridine(src)
	new /obj/item/container/beaker/bottle/kelotane(src)
	new /obj/item/container/beaker/bottle/dylovene(src)
	new /obj/item/container/syringe(src)
	new /obj/item/container/medicine/trauma_kit(src)
	new /obj/item/container/medicine/burn_kit(src)
	new /obj/item/container/spray/silver_sulfadiazine(src)
	new /obj/item/container/spray/styptic_powder(src)
	return ..()