/obj/item/bank_storage
	name = "bank storage"
	icon = null
	icon_state = null
	anchored = TRUE
	size = INFINITY
	weight = INFINITY
	var/owner //Ckey that owns it.

	is_container = TRUE

	max_inventory_x = 5
	dynamic_inventory_count = 5 * 5
	inventory_y_multiplier = -1
	starting_inventory_y = "TOP-2.25"

	dynamic_inventory_type = /obj/hud/inventory/dynamic/bank

	inventory_category = "bank"

	mouse_opacity = 0
	alpha = 0
	invisibility = 101

	queue_delete_immune = TRUE

/obj/item/bank_storage/on_crush()
	CRASH("ERROR: Tried crushing a bank object; something that should NEVER be crushed!")

/obj/item/bank_storage/Destroy()
	CRASH("ERROR: Tried deleting a bank object; something that should NEVER be deleted!")