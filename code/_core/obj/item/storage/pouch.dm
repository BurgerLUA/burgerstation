/obj/item/storage/pouch //For boxes and such, not backpacks.
	name = "small pouch"
	desc = "Simple pounches"
	desc_extended = "Storage pouches attachable to the groin or chest."
	icon = 'icons/obj/item/storage/pouches_new.dmi'

	size = SIZE_2


	is_container = TRUE

	container_max_size = SIZE_2
	dynamic_inventory_count = 1

	inventory_bypass = list(
		/obj/hud/inventory/organs/groin/pocket/right,
		/obj/hud/inventory/organs/groin/pocket/left
	)

/obj/item/storage/pouch/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(caller == object && is_advanced(caller))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		if(quick_equip(caller,TRUE))
			INTERACT_DELAY(1)
			return TRUE

	return ..()

/obj/item/storage/pouch/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && object.loc == caller && is_pocket(object) && click_self(caller,location,control,params))
		return TRUE

	return ..()

/obj/item/storage/pouch/single
	name = "single large pouch"
	desc_extended = "Storage pouches attachable to the groin or chest. This one can carry one Size 4 item, such as bulky guns."
	icon_state = "single"

	container_max_size = SIZE_4
	dynamic_inventory_count = 1

	size = SIZE_4

	value = 70


/obj/item/storage/pouch/single/black
	color = COLOR_BLACK

/obj/item/storage/pouch/single/brown
	color = COLOR_BROWN

/obj/item/storage/pouch/double
	name = "double medium pouches"
	desc_extended = "Storage pouches attachable to the groin or chest. This one can carry two Size 3 items, such as rifles or medkits."
	icon_state = "double"

	container_max_size = SIZE_3
	dynamic_inventory_count = 2

	size = SIZE_6

	value = 70


/obj/item/storage/pouch/double/black
	color = COLOR_BLACK

/obj/item/storage/pouch/double/brown
	color = COLOR_BROWN

/obj/item/storage/pouch/triple
	name = "triple small pouches"
	desc_extended = "Storage pouches attachable to the groin or chest. This one can carry three Size 2 items, such as a sidearm or extra ammo."
	icon_state = "triple"
	size = SIZE_6

	container_max_size = SIZE_2
	dynamic_inventory_count = 3

	value = 70


/obj/item/storage/pouch/triple/black/
	color = COLOR_BLACK

/obj/item/storage/pouch/triple/brown
	color = COLOR_BROWN
