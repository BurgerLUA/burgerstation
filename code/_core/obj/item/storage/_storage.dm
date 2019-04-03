/obj/item/storage/
	name = "storage"
	desc = "What could it contain?"

	icon_state = "box"
	icon = 'icons/obj/items/storage/boxes.dmi'

	size = 3

	is_container = TRUE
	container_max_size = 2

	inventories = list(
		/obj/inventory/dynamic,
		/obj/inventory/dynamic,
		/obj/inventory/dynamic,
		/obj/inventory/dynamic
	)