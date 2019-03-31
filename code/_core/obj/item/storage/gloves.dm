/obj/item/storage/glovebox/
	name = "glovebox"
	desc = "Contains a matching pair of gloves."
	icon_state = "glovebox"

	size = 2

	is_container = TRUE
	container_max_size = 1

	inventories = list(
		/obj/inventory/dynamic,
		/obj/inventory/dynamic
	)

/obj/item/storage/glovebox/yellow/
	name = "yellow glovebox"
	desc = "Contains 2 yellow gloves."

/obj/item/storage/glovebox/yellow/on_spawn()
	var/obj/item/clothing/hands/gloves/colored/yellow/G1 = new(src.loc)
	var/obj/item/clothing/hands/gloves/colored/yellow/left/G2 = new(src.loc)
	inventories[1].add_held_object(G1,bypass_checks = TRUE)
	inventories[2].add_held_object(G2,bypass_checks = TRUE)
