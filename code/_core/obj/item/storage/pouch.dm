/obj/item/storage/pouch //For boxes and such, not backpacks.
	name = "small pouch"
	desc = "Simple pounches"
	icon = 'icons/obj/items/storage/pouches_new.dmi'

	size = SIZE_2
	weight = WEIGHT_2

	is_container = TRUE

	container_max_size = SIZE_2
	dynamic_inventory_count = 1

	inventory_bypass = list(
		/obj/hud/inventory/organs/groin/pocket/right,
		/obj/hud/inventory/organs/groin/pocket/left
	)

/obj/item/storage/pouch/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(caller == object && is_advanced(caller) && quick_equip(caller))
		return TRUE

	return ..()

/obj/item/storage/pouch/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && object.loc == caller && is_pocket(object) && click_self(caller,location,control,params))
		return TRUE

	return ..()

/obj/item/storage/pouch/single
	name = "single large pouch"
	icon_state = "single"

	container_max_size = SIZE_4
	dynamic_inventory_count = 1

	size = SIZE_4
	weight = WEIGHT_2

/obj/item/storage/pouch/single/black
	color = COLOR_BLACK

/obj/item/storage/pouch/double
	name = "double medium pouches"
	icon_state = "double"

	container_max_size = SIZE_3
	dynamic_inventory_count = 2

	size = SIZE_6
	weight = WEIGHT_3

/obj/item/storage/pouch/double/black
	color = COLOR_BLACK

/obj/item/storage/pouch/double/brown
	color = COLOR_BROWN

/obj/item/storage/pouch/triple
	name = "triple small pouches"
	icon_state = "triple"
	dynamic_inventory_count = 6
	size = SIZE_6
	weight = WEIGHT_4

	container_max_size = SIZE_2
	dynamic_inventory_count = 3

	size = SIZE_6
	weight = WEIGHT_3

/obj/item/storage/pouch/triple/black/
	color = COLOR_BLACK

/obj/item/storage/pouch/triple/brown
	color = COLOR_BROWN