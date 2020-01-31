obj/item/clothing/back/storage/backpack/bluespace
	name = "bag of holding"
	desc = "Oh god how the fuck am I supposed to find anything in here?"
	desc_extended = "Holds up to 64 items in 16 slots."

	icon = 'icons/obj/items/clothing/back/backpack/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*4
	container_max_size = 100 //Can hold anything, almost.

	weight = WEIGHT_4

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace
	)


obj/item/clothing/back/storage/satchel/bluespace
	name = "satchel of holding"
	desc_extended = "A smaller version of the bag of holding that can fit in backpacks. Can hold up to 32 items in 8 slots."

	icon = 'icons/obj/items/clothing/back/satchel/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3
	container_max_size = 100 //Can hold anything, almost.

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
	new /obj/item/weapon/ranged/bullet/magazine/pistol/mercenary_modified(src)
	new /obj/item/weapon/ranged/bullet/pump/combat_shotgun_modified(src)
	new /obj/item/storage/pouch/triple/brown/filled/buckshot(src)
	new /obj/item/storage/pouch/triple/brown/filled/pistol(src)
	new /obj/item/storage/ammo/buckshot(src)
	new /obj/item/storage/ammo/buckshot(src)
	return ..()

