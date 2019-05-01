/obj/item/storage/shoebox/
	name = "shoebox"
	desc = "Contains a matching pair of shoes."
	icon_state = "shoebox"

	size = 2

	is_container = TRUE
	container_max_size = 1

	dynamic_inventory_count = 2

/obj/item/storage/shoebox/black/
	name = "black shoebox"
	desc = "Contains 2 plain black shoes."

/obj/item/storage/shoebox/black/on_spawn()
	var/obj/item/clothing/feet/shoes/black/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/black/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)
