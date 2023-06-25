/obj/item/clothing/back/storage/backpack/bluespace
	name = "bluespace bag of holding"
	desc = "Sticking your head in isn't recommended."
	desc_extended = "A special backpack that creates its own pocket inside the bluespace dimension to store an absurd amount of items. It's extremely heavy, however, and only practical for hauling items over long distances."
	icon = 'icons/obj/item/clothing/back/backpack/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*5
	container_max_size = SIZE_5

	size = MAX_INVENTORY_X*5*SIZE_5

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace/prank,
		/obj/item/clothing/belt/holding
	)

	value = 3000

	rarity = RARITY_MYTHICAL

	speed_bonus = -0.2

	value_burgerbux = 1

/obj/item/clothing/back/storage/satchel/bluespace
	name = "bluespace satchel of holding"
	desc = "Let me just get my two handed sword from my inter-dimensional purse."
	desc_extended = "A special satchel that creates its own pocket inside the bluespace dimension to store an absurd amount of items. While a smaller and lighter variant of the bluespace bag of holding, it's still very heavy, however, and only practical for hauling items over long distances."

	icon = 'icons/obj/item/clothing/back/satchel/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*4
	container_max_size = SIZE_4

	size = MAX_INVENTORY_X*4*SIZE_4

	container_blacklist = list(
		/obj/item/clothing/back/storage/backpack/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace,
		/obj/item/clothing/back/storage/satchel/bluespace/prank,
		/obj/item/clothing/belt/holding
	)

	value = 2500

	rarity = RARITY_MYTHICAL

	speed_bonus = -0.1

	value_burgerbux = 1

	rarity = RARITY_RARE

/obj/item/clothing/back/storage/satchel/bluespace/prank
	name = "satchel of hold"
	desc = "What the fuck, this is just the worst."
	desc_extended = "A prank version of the satchel of holding. It has been cursed to only hold one object."

	dynamic_inventory_count = 1
	container_max_size = SIZE_9

	size = SIZE_10

	rarity = RARITY_RARE
