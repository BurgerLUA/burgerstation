/obj/item/storage/bags/goodie
	name = "goodie bag"
	icon = 'icons/obj/item/event_bag.dmi'

	dynamic_inventory_count = 9
	max_inventory_x = 3
	container_max_size = 0
	container_max_slots = 1

	loot_open_verb = "unwrap"

/obj/item/storage/bags/goodie/get_base_value()
	return loot_to_generate ? 5 : initial(value)

/obj/item/storage/bags/goodie/halloween
	name = "halloween goodie bag"
	icon_state = "halloween"

	loot_to_generate = /loot/halloween

	value = 50

/obj/item/storage/bags/goodie/kitbag
	name = "kitbag"
	desc = "Green bag for a green(?) fatigue."
	desc_extended = "Green kitbag for holding various tactical equipment. Or junk."
	icon = 'icons/obj/item/clothing/back/kitbag.dmi'
	icon_state = "inventory"

	loot_to_generate = null

	value = 250

	size = MAX_INVENTORY_X*2*SIZE_3

	dynamic_inventory_count = 8 //Double, just in case.
	container_max_size = SIZE_4
	container_max_slots = 1

/obj/item/storage/bags/goodie/kitbag/rev
	loot_to_generate = /loot/rev

/obj/item/storage/bags/goodie/kitbag/syndie
	loot_to_generate = /loot/syndie

/obj/item/storage/bags/goodie/kitbag/survivor
	loot_to_generate = /loot/survivor/reward


/*
/obj/item/storage/bags/goodie/loot_box
	name = "loot box"
	desc = "Gacha time"
	desc_extended = "A box filled with discarded items, why did you buy a box filled with literal trash again?."
	icon = 'icons/obj/item/storage/death_box.dmi'
	icon_state = "loot"

	value = 1500

	loot_to_generate = /loot/value/medium

	size = MAX_INVENTORY_X*2*SIZE_3

	dynamic_inventory_count = 8
	container_max_size = SIZE_4
	container_max_slots = 1

	open_verb = "unlock"
*/