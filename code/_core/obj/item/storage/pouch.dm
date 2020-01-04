/obj/item/storage/pouch //For boxes and such, not backpacks.
	name = "small pouch"
	desc = "Simple pounches"
	icon = 'icons/obj/items/storage/pouches_new.dmi'

	size = SIZE_2

	is_container = TRUE

	container_max_size = SIZE_2
	dynamic_inventory_count = 1

	inventory_bypass = list(
		/obj/hud/inventory/pocket/pocket01,
		/obj/hud/inventory/pocket/pocket02
	)

/obj/item/storage/pouch/clicked_on_by_object(var/atom/caller,var/atom/object,location,control,params)

	world.log << "[src].clicked_on_by_object([caller],[object])"

	if(is_inventory(object) && object.loc == caller && istype(object,/obj/hud/inventory/pocket/) && click_self(caller,location,control,params))
		return TRUE

	return ..()

/obj/item/storage/pouch/single
	name = "single pouch"
	icon_state = "single"
	size = SIZE_2*2
	dynamic_inventory_count = 2

/obj/item/storage/pouch/double
	name = "double pouch"
	icon_state = "double"
	size = SIZE_2*4
	dynamic_inventory_count = 4

/obj/item/storage/pouch/double/black
	color = "#404040"


/obj/item/storage/pouch/triple
	name = "triple pouch"
	icon_state = "triple"
	size = SIZE_2*6
	dynamic_inventory_count = 6