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
	desc = "Contains a pair of black shoes."

/obj/item/storage/shoebox/black/on_spawn()
	var/obj/item/clothing/feet/shoes/colored/black/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/colored/black/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)


/obj/item/storage/shoebox/jackboot/
	name = "black boot shoebox"
	desc = "Contains a pair of black boots."

/obj/item/storage/shoebox/jackboot/on_spawn()
	var/obj/item/clothing/feet/shoes/black_boots/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/black_boots/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)


/obj/item/storage/shoebox/winter/
	name = "winter boot shoebox"
	desc = "Contains a pair of winter boots. Good for protecting against the cold."

/obj/item/storage/shoebox/winter/on_spawn()
	var/obj/item/clothing/feet/shoes/winter/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/winter/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)



/obj/item/storage/shoebox/colored/
	name = "dyeable shoebox"
	desc = "Contains a pair of shoes which can be dyed."

/obj/item/storage/shoebox/colored/on_spawn()
	var/obj/item/clothing/feet/shoes/colored/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/colored/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)



/obj/item/storage/shoebox/clown/
	name = "clown shoebox"
	desc = "Contains a pair of shoes which can be dyed."

/obj/item/storage/shoebox/clown/on_spawn()
	var/obj/item/clothing/feet/shoes/clown/S1 = new(src.loc)
	var/obj/item/clothing/feet/shoes/clown/left/S2 = new(src.loc)
	inventories[1].add_held_object(S1,bypass_checks = TRUE)
	inventories[2].add_held_object(S2,bypass_checks = TRUE)

