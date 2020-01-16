/obj/item/storage/kit/
	name = "first aid kit"
	desc = "Carries medicine."
	icon = 'icons/obj/items/storage/kits.dmi'
	icon_state = "firstaid"

	is_container = TRUE

	size = SIZE_3
	container_max_size = SIZE_1
	dynamic_inventory_count = 8

/obj/item/storage/kit/filled/fill_inventory()
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/storage/bags/pills/dylovene_small(src)
	return ..()
