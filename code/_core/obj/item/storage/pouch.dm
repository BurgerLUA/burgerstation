/obj/item/storage/pouch //For boxes and such, not backpacks.
	name = "pouch"
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
	icon_state = "pouch_small2"
	size = 4
	dynamic_inventory_count = 2

/obj/item/storage/pouch/small3
	icon_state = "pouch_small3"
	size = 6
	dynamic_inventory_count = 3

/obj/item/storage/pouch/small4
	icon_state = "pouch_small4"
	size = 8
	dynamic_inventory_count = 4

/obj/item/storage/pouch/large1

	container_max_size = 3

	icon_state = "pouch_large1"
	size = 3
	dynamic_inventory_count = 1
