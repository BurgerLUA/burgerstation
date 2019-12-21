/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "rod"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = WEIGHT_1

	crafting_id = "glitch"

/obj/item/material/rod/steel
	name = "steel rod"
	desc = "The basic building material."
	crafting_id = "rod_steel"
	color = COLOR_STEEL

/obj/item/material/rod/steel/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()

/obj/item/material/rod/steel/spawn_25/on_spawn()
	item_count_current = 25
	update_icon()

/obj/item/material/rod/steel/spawn_10/on_spawn()
	item_count_current = 10
	update_icon()