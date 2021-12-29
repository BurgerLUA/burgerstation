/obj/item/clothing/belt/storage
	name = "leather belt"
	icon = 'icons/obj/item/clothing/belts/tool.dmi'
	desc = "4 strength,4 stam leather belt. Level 18."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."

	is_container = TRUE

	dynamic_inventory_count = MAX_INVENTORY_X

	size = MAX_INVENTORY_X*SIZE_1

	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = 20,
		PIERCE = 20
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
	. = ..()

/obj/item/clothing/belt/storage/medical
	name = "medical belt"
	icon = 'icons/obj/item/clothing/belts/medical.dmi'
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed. This one is medical themed."

/obj/item/clothing/belt/storage/medical/filled
	value_burgerbux = 1

/obj/item/clothing/belt/storage/medical/filled/fill_inventory()
	new /obj/item/container/beaker/bottle/bicaridine(src)
	new /obj/item/container/beaker/bottle/kelotane(src)
	new /obj/item/container/beaker/bottle/dylovene(src)
	new /obj/item/container/syringe(src)
	new /obj/item/container/medicine/trauma_kit(src)
	new /obj/item/container/medicine/burn_kit(src)
	new /obj/item/container/spray/silver_sulfadiazine(src)
	new /obj/item/container/spray/styptic_powder(src)
	. = ..()


/obj/item/clothing/belt/suspenders
	name = "red suspenders"
	icon = 'icons/obj/item/clothing/suit/suspenders.dmi'
	desc = "They suspend the illusion of mimery."
	desc_extended = "Fancy red suspenders that store a small number of objects. Has better protection of the torso and groin, however."

	is_container = TRUE

	dynamic_inventory_count = 6

	size = MAX_INVENTORY_X*SIZE_1

	container_max_size = SIZE_2

	defense_rating = list(
		BLADE = 30,
		PIERCE = 30
	)

	rarity = RARITY_UNCOMMON

	protected_limbs = list(BODY_GROIN,BODY_TORSO)

	value = 40