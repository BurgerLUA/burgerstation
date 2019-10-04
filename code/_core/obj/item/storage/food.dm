/obj/item/storage/foodbox/
	name = "food box"
	desc = "Contains food"

/obj/item/storage/foodbox/donkbox/
	name = "box of donk pockets"
	icon_state = "donkbox"
	size = 3
	container_max_size = 1
	dynamic_inventory_count = 8

/obj/item/storage/foodbox/donkbox/on_spawn()
	/*
	for(var/i=1,i<=8,i++)
		var/obj/item/consumable/food/processed/donkpocket/D = new(src.loc)
		inventories[i].add_held_object(D,bypass_checks = TRUE)
	*/