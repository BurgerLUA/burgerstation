/obj/item/material/rod
	name = "rod"
	desc = "I am error."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "rod"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	crafting_id = "rod"

/obj/item/material/rod/steel
	name = "steel rod"
	desc = "The basic building material."
	material_id = /material/steel

/obj/item/material/rod/steel/spawn_50/Generate()
	item_count_current = 50
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_25/Generate()
	item_count_current = 25
	update_sprite()
	return ..()

/obj/item/material/rod/steel/spawn_10/Generate()
	item_count_current = 10
	update_sprite()
	return ..()