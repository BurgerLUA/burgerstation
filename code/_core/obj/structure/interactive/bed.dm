obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	var/second_color = "#ff0000"

	var/mob/living/occupant

obj/structure/interactive/bed/New()
	update_icon()
	. = ..()

obj/structure/interactive/bed/padded
	name = "padded bed"


obj/structure/interactive/bed/padded/update_icon()
	overlays.Cut()
	var/icon/sheets = new(icon,"bed_padding")
	overlays += sheets

/*

obj/structure/interactive/bed/padded/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new(icon,icon_state)
	var/icon/I2 = new(icon,"bed_padding")

	I.Blend(I2,ICON_OVERLAY)

	icon = I
*/

obj/structure/interactive/bed/sleeper
	name = "sleeper"
	icon_state = "sleeper"

	desired_light_power = 0.25
	desired_light_range = 3
	desired_light_color = "#3AC2FF"


