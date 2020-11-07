/obj/item/material/ore
	name = "ore"
	desc = "I am an ore."
	icon = 'icons/obj/item/material.dmi'
	icon_state = "ore"

	item_count_current = 1
	item_count_max = 1
	item_count_max_icon = 1

	crafting_id = "ore"


/obj/item/material/ore/Crossed(atom/movable/O)

	if(istype(O,/obj/structure/interactive/ore_box))
		var/obj/structure/interactive/ore_box/OB = O
		src.drop_item(OB)

	return ..()