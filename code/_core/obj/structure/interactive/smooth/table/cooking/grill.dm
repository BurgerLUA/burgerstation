/obj/structure/smooth/table/cooking/grill
	name = "electric grill"
	desc = "Cook things with this."
	desc_extended = "You can cook or heat up items by dropping it on top of the grill. Click on it with an empty hand to toggle the grill."
	icon = 'icons/obj/structure/smooth/table/grill.dmi'
	icon_state = "grill"

	layer = LAYER_TABLE

	corner_category = "table_reinforced"
	corner_icons = FALSE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	anchored = TRUE

/obj/structure/smooth/table/cooking/grill/update_icon()
	. = ..()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(enabled)
		icon_state = "[icon_state]_on"
	else
		icon_state = "[icon_state]_off"
	flick(src,"[icon_state]_anim")
