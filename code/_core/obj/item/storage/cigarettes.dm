/obj/item/storage/cigarettes
	name = "cigarette carton"
	desc = "Stores cigarettes."
	desc_extended = "A blank box of cigarettes."
	icon = 'icons/obj/item/storage/cigarette_packages.dmi'
	icon_state = "blank"

	dynamic_inventory_count = 10
	container_max_slots = 1
	container_max_size = SIZE_1

	container_whitelist = list(
		/obj/item/container/cigarette,
	)

	size = SIZE_2

	max_inventory_x = 5

	var/open = FALSE

	var/obj/item/storage/cigarettes/cigarette_type

	value = 5

/obj/item/storage/cigarettes/click_self(var/mob/caller)

	if(open && caller.attack_flags & CONTROL_MOD_DISARM)
		open = FALSE
		update_sprite()
		return TRUE

	if(!open)
		open = TRUE
		update_sprite()

	. = ..()

/obj/item/storage/cigarettes/update_icon()

	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(open)
		icon_state = "[icon_state]_open"

/obj/item/storage/cigarettes/update_overlays()
	. = ..()
	if(open)
		var/filled_slots = 0
		for(var/k in src.inventories)
			var/obj/hud/inventory/I = k
			filled_slots += length(I.contents)
		var/image/I = new/image(icon,"cig_[filled_slots]")
		add_overlay(I)

/obj/item/storage/cigarettes/update_inventory()
	. = ..()
	update_sprite()

/obj/item/storage/cigarettes/fill_inventory()
	if(cigarette_type)
		for(var/i=1,i<=dynamic_inventory_count,i++)
			new cigarette_type(src)

	desc_extended = "A box of [dynamic_inventory_count] [name]. Space FDA Approved and regulated. The lettering on the bottom indicates that the distributor and manufacturer are not legally held responsible for any injuries and/or deaths when using this product."

	. = ..()

/obj/item/storage/cigarettes/red
	name = "\improper NanoTrasen Red Label cigarettes"
	cigarette_type = /obj/item/container/cigarette/red
	icon_state = "red"

/obj/item/storage/cigarettes/gold
	name = "\improper NanoTrasen Gold Label cigarettes"
	cigarette_type = /obj/item/container/cigarette/gold
	icon_state = "gold"

/obj/item/storage/cigarettes/blue
	name = "\improper Water Smooth cigarettes"
	cigarette_type = /obj/item/container/cigarette/blue
	icon_state = "blue"

/obj/item/storage/cigarettes/green
	name = "\improper Freshmith cigarettes"
	cigarette_type = /obj/item/container/cigarette/green
	icon_state = "green"

/obj/item/storage/cigarettes/purple
	name = "\improper Hip Hipster cigarettes"
	cigarette_type = /obj/item/container/cigarette/purple
	icon_state = "purple"

/obj/item/storage/cigarettes/orange
	name = "\improper Western Classic cigarettes"
	cigarette_type = /obj/item/container/cigarette/orange
	icon_state = "orange"

/obj/item/storage/cigarettes/syndicate
	name = "\improper Syndicate Smokes cigarettes"
	cigarette_type = /obj/item/container/cigarette/syndicate
	icon_state = "syndicate"

/obj/item/storage/cigarettes/russian
	name = "\improper Russian Blue cigarettes"
	cigarette_type = /obj/item/container/cigarette/russian
	icon_state = "russian"