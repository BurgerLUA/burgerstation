/turf/simulated/wall/ash
	name = "ash wall"

	desc = "Gotta catch em all"
	desc_extended = "A solid wall of ash."

	real_icon = 'icons/turf/floor/rocky_ash.dmi'
	real_icon_state = "floor"

	icon = 'icons/turf/wall/rock/preview.dmi'
	icon_state = "ash"

	corner_icons = TRUE
	corner_category = "ash_wall"

	destruction_turf = /turf/simulated/floor/colored/ash

	layer = LAYER_WALL_LARGE

	health_base = 500

/*
/turf/simulated/wall/ash/update_overlays()
	. = ..()

	var/x_icon = x % 7
	var/y_icon = y % 7

	var/odd = ((y % 2) + x) % 2
	layer = odd ? 10 : 20

	var/image/I = new/image('icons/turf/wall/ash_overlays.dmi',"[x_icon],[y_icon]")
	I.blend_mode = BLEND_INSET_OVERLAY
	add_overlay(I)
*/


/turf/simulated/wall/ash/volcanic
	name = "volcanic ash wall"
	desc = "Gotta catch em all"
	desc_extended = "A solid wall of volcanic ash."
	color = "#705F5F"
	map_color = "#1C1714"

	destruction_turf = /turf/simulated/floor/colored/ash/volcanic