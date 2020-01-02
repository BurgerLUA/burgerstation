/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "sheet"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = WEIGHT_2

	crafting_id = "sheet_steel"

	material_id = "steel"


/obj/item/material/sheet/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			var/obj/item/material/rod/R = new(get_turf(src))
			R.material_id = material_id
			R.crafting_id = crafting_id
			R.item_count_current = 4
			caller.to_chat("You cut \the [src.name] into 4 [R.name].")
			item_count_current--
			update_icon()

	return ..()

/obj/item/material/sheet/steel
	name = "steel sheets"
	desc = "The basic building material."
	crafting_id = "sheet_steel"
	color = COLOR_STEEL

/obj/item/material/sheet/steel/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()
	return ..()

/obj/item/material/sheet/steel/spawn_25/on_spawn()
	item_count_current = 25
	update_icon()
	return ..()

/obj/item/material/sheet/steel/spawn_10/on_spawn()
	item_count_current = 10
	update_icon()
	return ..()
