/turf/simulated/floor/cobblestone
	name = "cobblestone"
	icon = 'icons/turf/floor/path.dmi'
	icon_state = "cobble_center"
	color = "#888888"

	layer = LAYER_FLOOR_TILE

	footstep = /footstep/concrete

	destruction_turf = /turf/simulated/floor/colored/dirt

	map_color = COLOR_GREY

/turf/simulated/floor/cobblestone/side
	icon_state = "cobble_side"


/turf/simulated/floor/cobblestone/corner
	icon_state = "cobble_corner"


/turf/simulated/floor/brick
	name = "brick floor"
	icon = 'icons/turf/floor/brick.dmi'
	icon_state = "0,0"
	color = "#FFFFFF"

	footstep = /footstep/concrete

	destruction_turf = /turf/simulated/floor/colored/dirt

/turf/simulated/floor/brick/New(var/desired_loc)
	icon_state = "[x % 10],[y % 10]"
	map_color = color
	. = ..()

/turf/simulated/floor/brick/grey
	color = "#728072"

/turf/simulated/floor/brick/grey/dark
	color = COLOR_GREY_DARK

/turf/simulated/floor/brick/grey/dark/ish
	color = "#444444"

/turf/simulated/floor/brick/sand
	color = "#AE8A67"