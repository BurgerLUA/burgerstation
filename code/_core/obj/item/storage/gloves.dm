/obj/item/storage/glovebox/
	name = "white glovebox"
	desc = "Contains a matching pair of gloves."
	icon_state = "glovebox"

	size = 2

	is_container = TRUE
	container_max_size = 1

	dynamic_inventory_count = 2

/obj/item/storage/glovebox/on_spawn()
	var/obj/item/clothing/hands/gloves/colored/G1 = new(src.loc)
	var/obj/item/clothing/hands/gloves/colored/left/G2 = new(src.loc)
	inventories[1].add_held_object(G1,bypass_checks = TRUE)
	inventories[2].add_held_object(G2,bypass_checks = TRUE)

/obj/item/storage/glovebox/yellow/
	name = "insulated glovebox"
	desc = "Contains 2 insulated yellow gloves."

/obj/item/storage/glovebox/yellow/on_spawn()
	var/obj/item/clothing/hands/gloves/colored/yellow/G1 = new(src.loc)
	var/obj/item/clothing/hands/gloves/colored/yellow/left/G2 = new(src.loc)
	inventories[1].add_held_object(G1,bypass_checks = TRUE)
	inventories[2].add_held_object(G2,bypass_checks = TRUE)



/obj/item/storage/glovebox/padded/
	name = "padded glovebox"
	desc = "Contains 2 padded black gloves. Perfect for winter conditions."

/obj/item/storage/glovebox/padded/on_spawn()
	var/obj/item/clothing/hands/gloves/colored/padded/black/G1 = new(src.loc)
	var/obj/item/clothing/hands/gloves/colored/padded/black/left/G2 = new(src.loc)
	inventories[1].add_held_object(G1,bypass_checks = TRUE)
	inventories[2].add_held_object(G2,bypass_checks = TRUE)
