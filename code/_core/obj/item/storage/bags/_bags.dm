/obj/item/storage/bags
	name = "specific item type bags"
	icon = 'icons/obj/items/storage/bags.dmi'
	icon_state = "mining"

/obj/item/storage/bags/mining
	name = "mining bag"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots. Holds up to 40 ores or ingots."
	icon_state = "mining"

	dynamic_inventory_count = 6
	container_max_size = 3
	container_max_weight = 100
	container_held_slots = 10
	container_whitelist = list(
		/obj/item/material/ore,
		/obj/item/material/ingot
	)

/obj/item/storage/bags/mining/bluespace
	name = "bluespace mining bag"
	icon_state = "mining_bluespace"
	desc_extended = "A giant orange bag that is designed to hold all your ores and ingots, now in bluespace. Holds up to 90 ores or ingots."
	dynamic_inventory_count = 6
	container_max_size = 100
	container_max_weight = 200
	container_held_slots = 30


/obj/item/storage/bags/chemistry
	name = "chemistry bag"
	desc_extended = "A giant white and orange bag that is designed to hold all your medicine. Holds up to 40 objects."
	icon_state = "chemistry"

	dynamic_inventory_count = 6
	container_max_size = 100
	container_max_weight = 100
	container_held_slots = 10
	container_whitelist = list(
		/obj/item/container/beaker,
		/obj/item/container/pill,
		/obj/item/container/syringe,
		/obj/item/storage/bags/pills,
	)

/obj/item/storage/bags/chemistry/filled/fill_inventory()


/obj/item/storage/bags/pills
	name = "pill bottle"
	desc_extended = "A pill bottle that can hold up to 30 pills."
	icon = 'icons/obj/items/storage/bottles.dmi'
	icon_state = "pill_canister"

	size = SIZE_2
	weight = WEIGHT_2

	dynamic_inventory_count = 1
	container_max_size = SIZE_1
	container_max_weight = WEIGHT_1
	container_held_slots = 30
	container_whitelist = list(
		/obj/item/container/pill,
	)

/obj/item/storage/bags/pills/bicaridine
	name = "bicaridine pill bottle"
	desc = "Contains 20 20u bicaridine pills."

/obj/item/storage/bags/pills/bicaridine/fill_inventory()
	for(var/i=1,i<=20,i++)
		var/obj/item/container/pill/bicaridine/P = new(src)
		P.on_spawn()
	return ..()


/obj/item/storage/bags/pills/kelotane
	name = "kelotane pill bottle"
	desc = "Contains 20 20u kelotane pills."

/obj/item/storage/bags/pills/kelotane/fill_inventory()
	for(var/i=1,i<=20,i++)
		var/obj/item/container/pill/kelotane/P = new(src)
		P.on_spawn()
	return ..()

/obj/item/storage/bags/pills/dylovene
	name = "dylovene pill bottle"
	desc = "Contains 20 20u dylovene pills."

/obj/item/storage/bags/pills/dylovene/fill_inventory()
	for(var/i=1,i<=20,i++)
		var/obj/item/container/pill/dylovene/P = new(src)
		P.on_spawn()
	return ..()


/obj/item/storage/bags/pills/dylovene_small
	name = "dylovene pill bottle"
	desc = "Contains 10 20u dylovene pills."

/obj/item/storage/bags/pills/dylovene/fill_inventory()
	for(var/i=1,i<=10,i++)
		var/obj/item/container/pill/dylovene/P = new(src)
		P.on_spawn()
	return ..()