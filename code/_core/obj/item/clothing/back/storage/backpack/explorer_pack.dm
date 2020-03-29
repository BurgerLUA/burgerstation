obj/item/clothing/back/storage/backpack/explorer
	name = "explorer's pack"
	desc = "Lightweight and reliable!"
	desc_extended = "A small gear harness designed to carry a small amount of large items. Perfect for looters of the battlefield."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/items/clothing/back/backpack/explorer_pack.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_3
	container_max_size = SIZE_4

	weight = WEIGHT_2

	value = 20


obj/item/clothing/back/storage/backpack/explorer/loadout


obj/item/clothing/back/storage/backpack/explorer/loadout/miner/fill_inventory()
	new /obj/item/device/radio(src)
	new /obj/item/pinpointer/custom(src)
	new /obj/item/pinpointer/landmark(src)
	new /obj/item/clothing/uniform/miner(src)
	new /obj/item/clothing/feet/shoes/miner(src)
	new /obj/item/clothing/feet/shoes/miner/left(src)
	new /obj/item/clothing/hands/gloves/colored/black(src)
	new /obj/item/clothing/hands/gloves/colored/black/left(src)
	new /obj/item/clothing/overwear/armor/explorer_suit(src)
	new /obj/item/clothing/belt/storage/colored/brown/filled/miner(src)
	new /obj/item/clothing/mask/gas/mining(src)
	new /obj/item/weapon/ranged/bullet/magazine/rifle/lmg(src)
	new /obj/item/magazine/lmg_556(src)
	new /obj/item/magazine/lmg_556(src)
	new /obj/item/magazine/lmg_556(src)
	new /obj/item/magazine/lmg_556(src)
	return ..()