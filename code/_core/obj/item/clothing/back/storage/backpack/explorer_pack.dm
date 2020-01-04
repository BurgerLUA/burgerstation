obj/item/clothing/back/storage/backpack/explorer
	name = "explorer's pack"
	icon = 'icons/obj/items/clothing/back/backpack/explorer_pack.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_2
	container_max_size = SIZE_2

	weight = WEIGHT_2


obj/item/clothing/back/storage/backpack/explorer/loadout


obj/item/clothing/back/storage/backpack/explorer/loadout/miner/fill_inventory()

	new /obj/item/clothing/uniform/miner(src)
	new /obj/item/clothing/feet/shoes/miner(src)
	new /obj/item/clothing/feet/shoes/miner/left(src)
	new /obj/item/clothing/hands/gloves/colored/black(src)
	new /obj/item/clothing/hands/gloves/colored/black/left(src)
	new /obj/item/storage/bags/mining(src)
	new /obj/item/clothing/overwear/armor/explorer_suit(src)

	return ..()
