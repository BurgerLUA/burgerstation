/obj/item/clothing/head/hat/paperbag
	name = "paper bag"
	desc = "Put the MONEY in the BAG! PUT IT IN!"
	desc_extended = "Holds items but preferably food. Can be dyed. Can apply a logo by Alt-clicking nearby. Also a fashion statement when worn (must be empty)."
	icon = 'icons/obj/item/clothing/hats/paperbag.dmi'
	icon_state = "paperbag"
	var/logo = 1
	dynamic_inventory_count = 7
	container_held_slots = 1
	container_max_size = SIZE_1

	size = SIZE_2
	is_container = TRUE

	value = 10

	defense_rating = list(
		ARCANE = 25
	)

	dyeable = TRUE

	blocks_clothing = SLOT_FACE_WRAP | SLOT_HEAD

/obj/item/clothing/head/hat/paperbag/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("logo")
	return .

/obj/item/clothing/head/hat/paperbag/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("logo")
	Finalize()
	return .

/obj/item/clothing/head/hat/paperbag/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	if(caller.attack_flags & ATTACK_ALT)
		if(logo < 9)
			logo++
			update_sprite()
			caller.to_chat(span("notice","You change \the logo from \the [src.name]."))
			return TRUE
		else
			logo = 1
			update_sprite()
			caller.to_chat(span("notice","You wipe \the logo from \the [src.name]."))
			return TRUE

/obj/item/clothing/head/hat/paperbag/update_icon()

	. = ..()

	var/filled_slots = 1
	for(var/k in src.inventories)
		var/obj/hud/inventory/I3 = k
		filled_slots += length(I3.held_objects)

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = icon(icon,"[initial(icon_state)][clamp(filled_slots,1,2)]")
	var/icon/I2 = icon(icon,"logo[clamp(filled_slots,1,2)][logo]")
	I.Blend(I2,ICON_OVERLAY)
	icon = I

	if(filled_slots == 1)
		item_slot = SLOT_HEAD
	else
		item_slot = SLOT_NONE

	return .

/obj/item/clothing/head/hat/paperbag/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location.item_slot & SLOT_HEAD)
		dynamic_inventory_count = 0
		is_container = FALSE
		var/mob/living/advanced/A = inventory_user
		for(var/obj/hud/inventory/dynamic/B in A.inventory)
			B.alpha = 0
			B.mouse_opacity = 0
		for(var/obj/hud/button/close_inventory/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0
	else
		dynamic_inventory_count = 7
		is_container = TRUE
	return .



/obj/item/clothing/head/hat/paperbag/update_inventory()
	. = ..()
	update_sprite()

	return .
