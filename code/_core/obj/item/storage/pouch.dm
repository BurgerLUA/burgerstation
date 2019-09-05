/obj/item/storage/pouch //For boxes and such, not backpacks.
	name = "small pouch"
	desc = "Simple pounches"

	icon_state = "pouch_small1"
	icon = 'icons/obj/items/storage/pouches.dmi'

	size = 2

	is_container = TRUE

	container_max_size = 2
	dynamic_inventory_count = 1

	inventory_bypass = list(
		/obj/hud/inventory/pocket/pocket01,
		/obj/hud/inventory/pocket/pocket02
	)

/obj/item/storage/pouch/on_inventory_click(var/mob/caller as mob,location,control,params)
	click_self(caller,location,control,params)
	return TRUE

/obj/item/storage/pouch/small2
	name = "small double pouch"
	icon_state = "pouch_small2"
	size = 4
	dynamic_inventory_count = 2

/obj/item/storage/pouch/small3
	name = "small triple pouch"
	icon_state = "pouch_small3"
	size = 6
	dynamic_inventory_count = 3

/obj/item/storage/pouch/small4
	name = "small quadruple pouch"
	icon_state = "pouch_small4"
	size = 8
	dynamic_inventory_count = 4

/obj/item/storage/pouch/large1
	name = "large pouch"

	container_max_size = 4
	container_max_weight = 10

	icon_state = "pouch_large1"
	size = 4
	dynamic_inventory_count = 1
	container_held_slots = 4


/obj/item/storage/pouch/bluespace
	name = "bluespace pouch"
	icon_state = "pouch_bluespace"
	size = 4
	dynamic_inventory_count = 1
	container_held_slots = 10
	container_max_size = 100
