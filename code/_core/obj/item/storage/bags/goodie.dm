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