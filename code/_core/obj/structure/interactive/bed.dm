obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/future/furniture.dmi'
	icon_state = "bed"
	var/second_color = "#ff0000"

obj/structure/interactive/bed/New()
	update_icon()
	. = ..()

obj/structure/interactive/bed/update_icon()
	overlays = null
	var/icon/sheets = new(icon,"bed_padding")
	overlays += sheets