obj/item/clothing/back/storage/backpack/bluespace
	name = "bag of holding"
	desc = "Oh god how the fuck am I supposed to find anything in here?"
	desc_extended = "Holds up to 64 items in 16 slots."

	icon = 'icons/obj/items/clothing/back/backpack/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*2
	container_held_slots = MAX_INVENTORY_X*0.5
	container_max_size = 100 //Can hold anything, almost.

	weight = WEIGHT_4


obj/item/clothing/back/storage/satchel/bluespace
	name = "satchel of holding"
	desc_extended = "A smaller version of the bag of holding that can fit in backpacks. Can hold up to 32 items in 8 slots."

	icon = 'icons/obj/items/clothing/back/satchel/bluespace.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X
	container_held_slots = MAX_INVENTORY_X*0.5

	weight = WEIGHT_4
