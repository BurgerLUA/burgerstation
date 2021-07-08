/turf/simulated/wall/ash
	name = "ash wall"

	desc = "Gotta catch em all"
	desc_extended = "A solid wall of ash."

	real_icon = 'icons/turf/floor/ash.dmi'
	real_icon_state = "floor"

	icon = 'icons/turf/wall/rock_preview.dmi'
	icon_state = "ash"

	corner_icons = TRUE
	corner_category = "ash_wall"

	destruction_turf = /turf/simulated/floor/colored/ash

/turf/simulated/wall/ash/update_overlays()
	. = ..()

	var/x_icon = x % 12
	var/y_icon = y % 12

	var/odd = ((y % 2) + x) % 2
	layer = odd ? 10 : 20

	var/image/I = new/image('icons/turf/wall/ash_overlays.dmi',"[x_icon],[y_icon]")
	I.blend_mode = BLEND_MULTIPLY
	I.appearance_flags = RESET_COLOR
	add_overlay(I)


/turf/simulated/wall/ash/dark
	name = "volcanic ash wall"
	desc = "Gotta catch em all"
	desc_extended = "A solid wall of volcanic ash."
	color = "#262626"