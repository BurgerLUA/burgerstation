/obj/item/clothing/back/storage/backpack/bluespace
	name = "bag of holding"
	desc = "Sticking your head in isn't recommended."
	desc_extended = "A special backpack that creates its own pocket inside the bluespace dimension to store an absurd amount of items. It's extremely heavy, however, and only practical for hauling items over long distances."
	icon = 'icons/obj/item/clothing/back/backpack/bluespace.dmi'
	rarity = RARITY_RARE


	dynamic_inventory_count = MAX_INVENTORY_X*4
	container_max_size = SIZE_6

	size = MAX_INVENTORY_X*4*SIZE_3
	weight = WEIGHT_7

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace
	)

	value = 800

/obj/item/clothing/back/storage/satchel/bluespace
	name = "satchel of holding"
	desc = "Let me just get X from my inter-dimensional purse."
	desc_extended = "A smaller version of the bag of holding. Very spacious despite that."

	icon = 'icons/obj/item/clothing/back/satchel/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*3
	container_max_size = SIZE_6

	size = MAX_INVENTORY_X*4*SIZE_3
	weight = WEIGHT_3

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace
	)

	value = 600