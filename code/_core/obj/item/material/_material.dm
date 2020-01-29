/obj/item/material/
	name = "glitch"
	desc = "I am error."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "shard_1"

	var/material_id = "glitch"

	item_count_current = 1
	item_count_max = 50
	item_count_max_icon = 3

	crafting_id = "material"

/obj/item/material/on_spawn()
	. = ..()
	update_icon()
	return .
