/obj/item/clothing/head/helmet/full/paperbag
	name = "paper bag"
	desc = "Put the MONEY in the BAG! PUT IT IN!"
	desc_extended = "Holds items but preferably food. Can be dyed. Can change the design by Alt-clicking it in your hand. Also a fashion statement when worn (must be empty)."
	icon = 'icons/obj/item/clothing/hats/paperbag.dmi'
	var/logo = 0
	var/logobg = 0
	dynamic_inventory_count = MAX_INVENTORY_X
	container_max_size = SIZE_2

	size = SIZE_3
	is_container = TRUE

	value = 10

	defense_rating = list(
		ARCANE = 20,
		HEAT = -20
	)

	polymorphs = list(
		"base" = "#F9B583",
		"logo" = "#FFFFFF",
		"logobg" = "#FFFFFF"
	)

	dyeable = TRUE

/obj/item/clothing/head/helmet/full/paperbag/Finalize()
	. = ..()
	update_inventory()

/obj/item/clothing/head/helmet/full/paperbag/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("logo")
	SAVEVAR("logobg")

/obj/item/clothing/head/helmet/full/paperbag/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("logo")
	LOADVAR("logobg")

/obj/item/clothing/head/helmet/full/paperbag/click_self(var/mob/caller)

	var/mob/C = caller
	if(C.attack_flags & CONTROL_MOD_DISARM && istype(src.loc,/obj/hud/inventory/organs/))
		INTERACT_CHECK
		var/choice = input("What do you want to change on \the [src.name]?","Design Selection") as null|anything in list("Logo","Background")
		if(choice == "Logo")
			var/logomenu = list(
				"none" = 0,
				"nanotrasen" = 1,
				"syndicate" = 3,
				"mchonk" = 2,
				"heart" = 4,
				"happy" = 5
			)
			INTERACT_CHECK
			choice = input("What do you want to change the logo to?","Logo Selection") as null|anything in logomenu
			if(choice)
				INTERACT_CHECK
				logo = logomenu[choice]
				caller.to_chat(span("notice","You change \the [src.name]'s logo."))
		else if(choice == "Background")
			var/bgmenu = list(
				"none" = 0,
				"stripe" = 1,
				"circle" = 2
			)

			INTERACT_CHECK
			choice = input("What do you want to change the background to?","Background Selection") as null|anything in bgmenu
			if(choice)
				INTERACT_CHECK
				logobg = bgmenu[choice]
				caller.to_chat(span("notice","You change \the [src.name]'s background."))
		else
			caller.to_chat(span("notice","You decide not to change \the [src.name]'s design."))
			return TRUE
		update_sprite()
		return TRUE

	return ..()

/obj/item/clothing/head/helmet/full/paperbag/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location.item_slot & SLOT_HEAD)
		dynamic_inventory_count = 0
		is_container = FALSE
		if(inventory_user)
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

/obj/item/clothing/head/helmet/full/paperbag/update_inventory()
	. = ..()
	var/filled_slots = 1
	for(var/k in src.inventories)
		var/obj/hud/inventory/I3 = k
		filled_slots += length(I3.contents)

	if(filled_slots == 1)
		item_slot = SLOT_HEAD
		icon_state = "[initial(icon_state)]1"
	else
		item_slot = SLOT_NONE
		icon_state = "[initial(icon_state)]2"
	update_sprite()
	update_overlays()

/obj/item/clothing/head/helmet/full/paperbag/update_overlays()

	var/content_count = 1

	for(var/k in src.inventories)
		var/obj/hud/inventory/I3 = k
		content_count += length(I3.contents)

	var/image/I = new/image(initial(icon),"logobg[clamp(content_count,1,2)][logobg]")
	I.color = polymorphs["logobg"]
	add_overlay(I)

	var/image/I2 = new/image(initial(icon),"logo[clamp(content_count,1,2)][logo]")
	I2.color = polymorphs["logo"]
	add_overlay(I2)

	return ..()

/obj/item/clothing/head/helmet/full/paperbag/nanotrasen
	logo = 1
	logobg = 2
	polymorphs = list(
		"base" = "#145180",
		"logo" = "#FFFFFF",
		"logobg" = "#092337"
	)

/obj/item/clothing/head/helmet/full/paperbag/syndicate
	logo = 3
	logobg = 1
	polymorphs = list(
		"base" = "#AB0101",
		"logo" = "#FFFFFF",
		"logobg" = "#2A2A2A"
	)

/obj/item/clothing/head/helmet/full/paperbag/random/Generate()
	logo = rand(0,5)
	logobg = rand(0,2)
	return ..()