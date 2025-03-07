/obj/item/clothing/head/helmet/full/paperbag
	name = "paper bag"
	desc = "Put the MONEY in the BAG! PUT IT IN!"
	desc_extended = "Holds items but preferably food. Can be dyed. Can change the design by Alt-clicking it in your hand. Also a fashion statement when worn (must be empty)."
	icon = 'icons/obj/item/clothing/hats/paperbag.dmi'
	icon_state = "inventory"
	var/logo = 0
	var/logobg = 0
	dynamic_inventory_count = MAX_INVENTORY_X
	container_max_size = SIZE_2

	size = SIZE_3
	is_container = TRUE

	value = 10

	armor = /armor/cloth/flammable

	polymorphs = list(
		"base" = "#F9B583",
		"logo" = "#FFFFFF",
		"logobg" = "#FFFFFF"
	)

	dyeable = TRUE

/obj/item/clothing/head/helmet/full/paperbag/Finalize()
	. = ..()
	update_inventory()

/obj/item/clothing/head/helmet/full/paperbag/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("logo")
	SAVEVAR("logobg")

/obj/item/clothing/head/helmet/full/paperbag/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("logo")
	LOADVAR("logobg")

/obj/item/clothing/head/helmet/full/paperbag/click_self(var/mob/activator,location,control,params)

	var/mob/C = activator
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
				activator.to_chat(span("notice","You change \the [src.name]'s logo."))
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
				activator.to_chat(span("notice","You change \the [src.name]'s background."))
		else
			activator.to_chat(span("notice","You decide not to change \the [src.name]'s design."))
			return TRUE
		update_sprite()
		return TRUE

	return ..()

/obj/item/clothing/head/helmet/full/paperbag/pre_equip(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location.item_slot & SLOT_HEAD)
		src.close_inventory(src)
		dynamic_inventory_count = 0
		is_container = FALSE
	else
		dynamic_inventory_count = 7
		is_container = TRUE

/obj/item/clothing/head/helmet/full/paperbag/update_inventory()
	. = ..()
	update_sprite()

/obj/item/clothing/head/helmet/full/paperbag/update_icon()
	. = ..()
	icon = null
	icon_state = null

/obj/item/clothing/head/helmet/full/paperbag/update_overlays()

	. = ..()

	var/content_count = FALSE

	for(var/k in src.inventories)
		var/obj/hud/inventory/I3 = k
		if(length(I3.contents) > 0)
			content_count = TRUE
			break

	var/image/I1 = new/image(initial(icon),content_count ? "inventory1_base" : "inventory2_base")
	I1.color = polymorphs["base"]
	add_overlay(I1)

	var/image/I2 = new/image(initial(icon),"logobg[content_count ? 2 : 1][logobg]")
	I2.color = polymorphs["logobg"]
	add_overlay(I2)

	var/image/I3 = new/image(initial(icon),"logo[content_count ? 2 : 1][logo]")
	I3.color = polymorphs["logo"]
	add_overlay(I3)

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
	. = ..()
	logo = pick(0,2,4,5)
	logobg = rand(0,2)
	polymorphs = list(
		"base" = rgb(204,rand(112,184),rand(112,184)),
		"logo" = random_color(),
		"logobg" = random_color()
	)
