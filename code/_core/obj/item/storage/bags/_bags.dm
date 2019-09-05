/obj/item/storage/bags
	name = "specific item type bags"
	icon = 'icons/obj/items/storage/bags.dmi'
	icon_state = "mining"



/obj/item/storage/bags/mining
	name = "mining bag"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots. Holds up to 40 ores or ingots."
	icon_state = "mining"

	dynamic_inventory_count = 4
	container_max_size = 3
	container_max_weight = 100
	container_held_slots = 10
	container_whitelist = list(
		/obj/item/ore/,
		/obj/item/ingot/
	)

/obj/item/storage/bags/mining/bluespace
	name = "bluespace mining bag"
	icon_state = "mining_bluespace"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots, now in bluespace. Holds up to 90 ores or ingots."
	dynamic_inventory_count = 3
	container_max_size = 100
	container_max_weight = 200
	container_held_slots = 30