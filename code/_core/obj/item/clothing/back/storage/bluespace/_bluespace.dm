obj/item/clothing/back/storage/backpack/bluespace
	name = "bag of holding"
	desc = "Sticking your head in isn't recommended."
	desc_extended = "A special backpack that creates its own pocket inside the bluespace dimension to store an absurd amount of items. It's extremely heavy, however, and only practical for hauling items over long distances."
	icon = 'icons/obj/items/clothing/back/backpack/bluespace.dmi'
	rarity = RARITY_RARE


	dynamic_inventory_count = MAX_INVENTORY_X*4
	container_max_size = SIZE_6

	size = MAX_INVENTORY_X*4*SIZE_3
	weight = WEIGHT_7

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace
	)

	value = 90

obj/item/clothing/back/storage/satchel/bluespace
	name = "satchel of holding"
	desc_extended = "A smaller version of the bag of holding."

	icon = 'icons/obj/items/clothing/back/satchel/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3
	container_max_size = SIZE_6

	size = MAX_INVENTORY_X*4*SIZE_3
	weight = WEIGHT_3

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace
	)


obj/item/clothing/back/storage/satchel/bluespace/loadout/science/fill_inventory()
	new /obj/item/radio(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/pinpointer/custom(src)
	new /obj/item/clothing/uniform/jumpsuit/science(src)
	new /obj/item/clothing/glasses/prescription/blue(src)
	new /obj/item/clothing/overwear/armor/hardsuit/science(src)
	new /obj/item/clothing/belt/storage/colored/orange/filled/scientist(src)
	new /obj/item/weapon/ranged/bullet/magazine/pistol/military/mod(src)
	new /obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod(src)
	new /obj/item/storage/pouch/triple/brown/filled/buckshot(src)
	new /obj/item/storage/pouch/triple/brown/filled/pistol(src)
	new /obj/item/storage/ammo/buckshot(src)
	new /obj/item/storage/ammo/buckshot(src)
	return ..()

