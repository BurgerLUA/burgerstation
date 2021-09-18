/obj/structure/smooth/table/cooking/bonfire
	name = "bonfire"
	desc = "Cook things with this."
	desc_extended = "You can cook or heat up items by dropping it on top of the bonfire."
	icon = 'icons/obj/structure/bonfire.dmi'
	icon_state = "bonfire_warm"

	layer = LAYER_TABLE

	corner_category = null
	corner_icons = FALSE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	anchored = TRUE
	enabled = TRUE

	desired_light_power = 0.5
	desired_light_range = 4
	desired_light_color = "#FF7F00"