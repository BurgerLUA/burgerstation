/obj/item/material/glass
	name = "glass"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "glass"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	weight = WEIGHT_1

	crafting_id = "glass"
	material_id = "glass"

/obj/item/material/glass/normal
	name = "glass sheets"
	desc = "The basic building material."
	crafting_id = "glass_normal"
	color = COLOR_GLASS

/obj/item/material/glass/normal/spawn_50/on_spawn()
	item_count_current = 50
	update_icon()
	return ..()