/obj/item/material/sheet
	name = "sheet"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "sheet"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = WEIGHT_2

	crafting_id = "glitch"

	material_id = "steel"

/obj/item/material/sheet/steel
	name = "steel sheets"
	desc = "The basic building material."
	crafting_id = "sheet_steel"
	color = COLOR_STEEL

/obj/item/material/sheet/steel/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()

/obj/item/material/sheet/steel/spawn_25/on_spawn()
	item_count_current = 25
	update_icon()

/obj/item/material/sheet/steel/spawn_10/on_spawn()
	item_count_current = 10
	update_icon()
