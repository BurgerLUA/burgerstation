/obj/item/bank_storage
	name = "bank storage"
	icon = null
	icon_state = null
	anchored = TRUE
	value = -1
	size = INFINITY
	weight = INFINITY
	var/owner //Ckey that owns it.

	is_container = TRUE

	max_inventory_x = 10
	dynamic_inventory_count = 10 * 4
	inventory_y_multiplier = -1
	starting_inventory_y = "TOP-1.25"

	dynamic_inventory_type = /obj/hud/inventory/dynamic/bank


	inventory_category = "bank"