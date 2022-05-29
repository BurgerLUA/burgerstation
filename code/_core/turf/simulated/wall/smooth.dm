/turf/simulated/wall/plastic
	name = "plastic wall"
	desc = "Flexible"
	desc_extended = " A wall made of plastic."
	icon = 'icons/turf/wall/plastic.dmi'
	icon_state = "wall"
	corner_icons = TRUE
	corner_category = "plastic_wall"

	destruction_turf = /turf/simulated/floor/plating

/turf/simulated/wall/plastic/New(var/desired_loc)
	. = ..()
	map_color = color


/turf/simulated/wall/plastic/office
	name = "office wall"
	desc = "Flexible"
	desc_extended = " A wall made of plastic. This one seems boring."
	color = "#DED4C8"

/turf/simulated/wall/plastic/wizard
	name = "wizard wall"
	desc = "Flexible"
	desc_extended = " A wall made of plastic. This one seems magical."
	color = "#8034B2"