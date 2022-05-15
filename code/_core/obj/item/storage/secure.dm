/obj/item/storage/secure
	name = "secured universal storage device"
	desc = "It's bluespace, I ain't gotta explain shit."
	desc_extended = "Also known as an S.U.S. device, this device uses special shared-link storage to access items across the universe and dimensions. Very limited in what it can store, however. \
	<span class='danger'>WARNING: This device only works when slotted into the secure bluespace storage slot. Storage retrieval may not work if its not in the right slot!</span>"

	icon = 'icons/obj/item/storage/secure_box.dmi'
	icon_state = "basic"

	value = 1000

	max_inventory_x = 3
	dynamic_inventory_count = 3*2

	container_max_slots = 1
	container_max_size = SIZE_2

	is_container = TRUE

	size = (3*2*SIZE_2) + SIZE_3
	weight = 50

	dynamic_inventory_type = /obj/hud/inventory/dynamic/secure

	inventory_category = "secure"

	queue_delete_immune = TRUE