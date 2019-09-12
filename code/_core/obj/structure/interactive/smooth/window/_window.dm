/obj/structure/smooth/window
	name = "window"
	desc = "See through this."
	icon = 'icons/obj/structure/modern/window.dmi'
	icon_state = "window"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	corner_category = "window"
	corner_icons = TRUE

	layer = LAYER_OBJ_WINDOW

/obj/structure/smooth/window/reinforced
	name = "reinforced window"
	icon = 'icons/obj/structure/modern/window_reinforced.dmi'
	icon_state = "window"

/obj/structure/smooth/window/tinted
	name = "tinted window"
	desc = "Don't see through this."
	color = "#444444"
	opacity = 1


/obj/structure/smooth/window/clockwork
	name = "clockwork window"
	opacity = 1
	icon = 'icons/obj/structure/clockwork/window.dmi'
	icon_state = "window"

	light_power = 0.5
	light_range = 2
	light_color = "#E29E00"


/obj/structure/smooth/window/cult
	name = "cult window"
	color = "#7F0000"