/obj/item/material/ore
	name = "ore"
	desc = "I am an ore."
	icon = 'icons/obj/items/material.dmi'
	icon_state = "ore"

	item_count_current = 1
	item_count_max = 1
	item_count_max_icon = 1

	weight = 0.5

	crafting_id = "ore"


/obj/item/material/ore/Crossed(var/atom/movable/M,var/atom/NewLoc,var/atom/OldLoc)

	if(istype(M,/obj/structure/interactive/ore_box))
		var/obj/structure/interactive/ore_box/OB = M
		src.force_move(OB)

	return ..()