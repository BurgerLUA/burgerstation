/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "sheet"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = 1

	crafting_id = "sheet"

/obj/item/material/sheet/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			var/obj/item/material/rod/R = new(get_turf(src))
			R.material_id = material_id
			R.item_count_current = 4
			INITIALIZE(R)
			GENERATE(R)
			caller.to_chat("You cut \the [src.name] into 4 [R.name].")
			add_item_count(-1)
			R.Move(get_turf(I))

	return ..()

/obj/item/material/sheet/steel
	material_id = "steel"

/obj/item/material/sheet/steel/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()

/obj/item/material/sheet/steel/spawn_25/Generate()
	item_count_current = 25
	update_sprite()
	return ..()

/obj/item/material/sheet/steel/spawn_10/Generate()
	item_count_current = 10
	update_sprite()
	return ..()

/obj/item/material/sheet/glass
	material_id = "glass"

/obj/item/material/sheet/glass/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()