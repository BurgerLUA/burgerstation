/obj/item/storage/pillbottle
	name = "pill bottle"
	desc = "Be sure to read the label before eating the contents."
	desc_extended = "A pill bottle that can hold up to 30 pills."
	icon = 'icons/obj/item/storage/prescription_pillbottle.dmi'
	icon_state = "base"

	size = SIZE_1
	dynamic_inventory_count = 1
	container_max_size = SIZE_0
	container_max_slots = 30
	container_whitelist = list(
		/obj/item/container/edible/pill,
	)

	var/color_lid = "#FFFFFF"
	var/color_label = "#FFFFFF"
	var/color_canister = "#D35400"

	var/fill_icon_count = 7

	drop_sound = 'sound/items/drop/pillbottle.ogg'

	value = 20


/obj/item/storage/pillbottle/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("color_lid")
	SAVEVAR("color_label")
	SAVEVAR("color_canister")

/obj/item/storage/pillbottle/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("color_lid")
	LOADVAR("color_label")
	LOADVAR("color_canister")

/obj/item/storage/pillbottle/Finalize()
	. = ..()
	update_sprite()

/obj/item/storage/pillbottle/update_inventory()
	. = ..()
	update_sprite()

/obj/item/storage/pillbottle/update_overlays()

	. = ..()

	var/image/lid = new/image(icon,"lid")
	lid.appearance_flags = src.appearance_flags | RESET_COLOR
	lid.color = color_lid
	add_overlay(lid)

	var/image/canister = new/image(icon,"canister")
	canister.appearance_flags = src.appearance_flags | RESET_COLOR
	canister.color = color_canister
	add_overlay(canister)

	var/image/label = new/image(icon,"label")
	label.appearance_flags = src.appearance_flags | RESET_COLOR
	label.color = color_label
	add_overlay(label)


/obj/item/storage/pillbottle/update_icon()

	. = ..()

	if(fill_icon_count > 0)
		var/chosen_color
		var/filled_slots = 0
		for(var/k in src.inventories)
			var/obj/hud/inventory/I = k
			filled_slots += length(I.contents)
			if(!chosen_color)
				var/obj/item/I2 = I.get_top_object()
				if(I2) chosen_color = I2.color

		var/icon_mod = CEILING( (filled_slots/(dynamic_inventory_count*container_max_slots)) * fill_icon_count,1)
		icon_state = "contents_[icon_mod]"
		color = chosen_color
	else
		icon_state = null


/obj/item/storage/pillbottle/bicaridine
	name = "bicaridine pill bottle"
	desc = "Contains 20 5u bicaridine pills."

/obj/item/storage/pillbottle/bicaridine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/bicaridine(src)
	. = ..()

/obj/item/storage/pillbottle/bicaridine_small
	name = "bicaridine pill bottle"
	desc = "Contains 10 5u bicaridine pills."

/obj/item/storage/pillbottle/bicaridine_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/bicaridine(src)
	. = ..()

/obj/item/storage/pillbottle/kelotane
	name = "kelotane pill bottle"
	desc = "Contains 20 5u kelotane pills."

/obj/item/storage/pillbottle/kelotane/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/kelotane(src)
	. = ..()

/obj/item/storage/pillbottle/kelotane_small
	name = "kelotane pill bottle"
	desc = "Contains 10 5u kelotane pills."

/obj/item/storage/pillbottle/kelotane_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/kelotane(src)
	. = ..()

/obj/item/storage/pillbottle/dylovene
	name = "dylovene pill bottle"
	desc = "Contains 20 5u dylovene pills."

/obj/item/storage/pillbottle/dylovene/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/dylovene(src)
	. = ..()

/obj/item/storage/pillbottle/dylovene_small
	name = "dylovene pill bottle"
	desc = "Contains 10 5u dylovene pills."

/obj/item/storage/pillbottle/dylovene_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/dylovene(src)
	. = ..()


/obj/item/storage/pillbottle/iron
	name = "iron pill bottle"
	desc = "Contains 20 10u iron pills."

/obj/item/storage/pillbottle/iron/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/iron(src)
	. = ..()

/obj/item/storage/pillbottle/iron_small
	name = "iron pill bottle"
	desc = "Contains 10 10u iron pills."

/obj/item/storage/pillbottle/iron_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/iron(src)
	. = ..()

/obj/item/storage/pillbottle/omnizine
	name = "omnizine pill bottle"
	desc = "Contains 20 10u omnizine pills."

/obj/item/storage/pillbottle/omnizine/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/omnizine(src)
	. = ..()

/obj/item/storage/pillbottle/charcoal
	name = "charcoal pill bottle"
	desc = "Contains 20 10u charcoal pills."

/obj/item/storage/pillbottle/charcoal/fill_inventory()
	for(var/i=1,i<=20,i++)
		new /obj/item/container/edible/pill/charcoal(src)
	. = ..()

/obj/item/storage/pillbottle/antihol_small
	name = "antihol bottle"
	desc = "Contains 10 10u antihol pills."

/obj/item/storage/pillbottle/antihol_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/antihol(src)
	. = ..()

/obj/item/storage/pillbottle/potassium_iodide_small
	name = "potassium iodide pill bottle"
	desc = "Contains 10 10u potassium iodide pills."

/obj/item/storage/pillbottle/potassium_iodide_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/potassium_iodide(src)
	. = ..()

/obj/item/storage/pillbottle/space_prussian_blue_small
	name = "space prussian blue pill bottle"
	desc = "Contains 10 20u space prussian blue pills."

/obj/item/storage/pillbottle/space_prussian_blue_small/fill_inventory()
	for(var/i=1,i<=10,i++)
		new /obj/item/container/edible/pill/space_prussian_blue(src)
	. = ..()