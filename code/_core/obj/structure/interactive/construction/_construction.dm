/obj/structure/interactive/construction/
	name = "construction object"
	icon = 'icons/obj/structure/construction.dmi'
	mouse_opacity = 2
	var/material_id = /material/steel
	color = COLOR_STEEL

	health = /health/construction/

	structure_blacklist = list(
		/obj/structure/interactive/construction/
	)