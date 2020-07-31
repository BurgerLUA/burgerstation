/turf/simulated/floor/tile
	name = "tile floor"

	icon = 'icons/turf/floor/tile.dmi'
	icon_state = "white_multi"

	footstep = /footstep/tile

	layer = LAYER_FLOOR
	plane = PLANE_TILE

	exposed = FALSE

	destruction_turf = /turf/simulated/floor/plating

/turf/simulated/floor/tile/grey
	color = COLOR_GREY

/turf/simulated/floor/tile/blue_baby
	color = "#729AB1"

/turf/simulated/floor/tile/grey/single
	icon_state = "white_single"

/turf/simulated/floor/tile/grey/horizontal
	icon_state = "white_half_horz"

/turf/simulated/floor/tile/grey/vertical
	icon_state = "white_half_vert"

/turf/simulated/floor/tile/dark
	color = COLOR_STEEL

/turf/simulated/floor/tile/dark/er
	color = "#242424"

/turf/simulated/floor/tile/dark/single
	icon_state = "white_single"

/turf/simulated/floor/tile/dark/ish
	color = "#616060"

/turf/simulated/floor/tile/red
	color = COLOR_RED

/turf/simulated/floor/tile/security
	color = COLOR_SECURITY

/turf/simulated/floor/tile/blue
	color = COLOR_BLUE

/turf/simulated/floor/tile/nanotrasen
	color = COLOR_NANOTRASEN

/turf/simulated/floor/tile/green
	color = "#449944"

/turf/simulated/floor/tile/purple
	color = COLOR_PURPLE

/turf/simulated/floor/tile/orange
	color = "#FF9944"

/turf/simulated/floor/tile/brown
	color = "#995121"

/turf/simulated/floor/tile/tan
	color = "#D3CBA5"


/turf/simulated/floor/tile/yellow
	color = "#FFFF44"

/turf/simulated/floor/tile/engineering
	color = COLOR_ENGINEERING

/turf/simulated/floor/tile/cyan
	color = "#44FF99"

/turf/simulated/floor/tile/medical
	color = COLOR_MEDICAL

/turf/simulated/floor/tile/coldroom
	color = "#DBF9F9"

/turf/simulated/floor/tile/tint
	color = "#B0B5B4"

/turf/simulated/floor/tile/bananium
	icon_state = "bananium"

/turf/simulated/floor/tile/cargo
	color = COLOR_CARGO

/turf/simulated/floor/tile/command
	color = COLOR_COMMAND

/turf/simulated/floor/tile/overlapping
	real_icon = 'icons/turf/floor/tile_smooth_overlap.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "tile_over"

	layer = LAYER_FLOOR + 0.01

/turf/simulated/floor/tile/overlapping/should_smooth_with(var/turf/T)

	if(!istype(T,/turf/simulated/floor/tile/))
		return TRUE //This means it won't overlay with reinforced plates and whatnot, only tiles.

	if(T.color == color)
		return TRUE

	return ..()

/turf/simulated/floor/tile/overlapping/engineering
	color = COLOR_ENGINEERING
	layer = LAYER_FLOOR + 0.02

/turf/simulated/floor/tile/overlapping/grey
	color = "#999999"
	layer = LAYER_FLOOR + 0.03

/turf/simulated/floor/tile/overlapping/dark
	color = "#444444"
	layer = LAYER_FLOOR + 0.04





/*
/turf/simulated/floor/tile/smooth
	real_icon = 'icons/turf/floor/tile_smooth.dmi'
	real_icon_state = "floor"

	corner_icons = TRUE
	corner_category = "tile"


/turf/simulated/floor/tile/smooth/grey
	color = "#999999"

/turf/simulated/floor/tile/smooth/cargo
	color = COLOR_CARGO
*/