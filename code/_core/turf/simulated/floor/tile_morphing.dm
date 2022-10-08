/turf/simulated/floor/tile/morphing/
	icon = 'icons/turf/floor/tile_quad.dmi'
	icon_state = "multi"
	corner_icons = TRUE

/turf/simulated/floor/tile/morphing/should_smooth_with(var/turf/T)

	if(istype(T,/turf/simulated/floor/tile/) && !istype(T,/turf/simulated/floor/tile/morphing))
		return T

	return null

/turf/simulated/floor/tile/morphing/update_smooth_code()

	var/smooth_code_1_old = smooth_code_1
	var/smooth_code_2_old = smooth_code_2
	var/smooth_code_3_old = smooth_code_3
	var/smooth_code_4_old = smooth_code_4

	var/default_color = initial(color)
	if(!default_color)
		default_color = "#FFFFFF"

	var/turf/T_n = get_step(src,NORTH)
	var/turf/T_e = get_step(src,EAST)
	var/turf/T_s = get_step(src,SOUTH)
	var/turf/T_w = get_step(src,WEST)

	if(!is_tile(T_n))
		T_n = null
	if(!is_tile(T_e))
		T_e = null
	if(!is_tile(T_s))
		T_s = null
	if(!is_tile(T_w))
		T_w = null

	if(T_n && T_w && initial(T_n.color) == initial(T_w.color))
		smooth_code_1 = initial(T_n.color)
	else
		var/turf/T_nw = get_step(src,NORTHWEST)
		if(is_tile(T_nw))
			smooth_code_1 = initial(T_nw.color)
		else
			smooth_code_1 = default_color

	if(T_n && T_e && initial(T_n.color) == initial(T_e.color))
		smooth_code_2 = initial(T_n.color)
	else
		var/turf/T_ne = get_step(src,NORTHEAST)
		if(is_tile(T_ne))
			smooth_code_2 = initial(T_ne.color)
		else
			smooth_code_2 = default_color

	if(T_s && T_w && initial(T_s.color) == initial(T_w.color))
		smooth_code_3 = initial(T_s.color)
	else
		var/turf/T_sw = get_step(src,SOUTHWEST)
		if(is_tile(T_sw))
			smooth_code_3 = initial(T_sw.color)
		else
			smooth_code_3 = default_color

	if(T_s && T_e && initial(T_s.color) == initial(T_e.color))
		smooth_code_4 = initial(T_s.color)
	else
		var/turf/T_se = get_step(src,SOUTHEAST)
		if(is_tile(T_se))
			smooth_code_4 = initial(T_se.color)
		else
			smooth_code_4 = default_color

		. = FALSE

	if(!smooth_code_1) smooth_code_1 = "#FFFFFF"
	if(!smooth_code_2) smooth_code_2 = "#FFFFFF"
	if(!smooth_code_3) smooth_code_3 = "#FFFFFF"
	if(!smooth_code_4) smooth_code_4 = "#FFFFFF"

	if(smooth_code_1_old != smooth_code_1)
		. = TRUE
	else if(smooth_code_2_old != smooth_code_2)
		. = TRUE
	else if(smooth_code_3_old != smooth_code_3)
		. = TRUE
	else if(smooth_code_4_old != smooth_code_4)
		. = TRUE

	if(.)
		update_sprite()

/turf/simulated/floor/tile/morphing/update_icon()


	color = null

	var/full_icon_string = "[type]_[icon_state]_[smooth_code_1][smooth_code_2][smooth_code_3][smooth_code_4]"

	var/icon/I
	if(SSturf.icon_cache[full_icon_string])
		I = SSturf.icon_cache[full_icon_string]
		SSturf.saved_icons++
	else
		I = new/icon(icon,"nw")
		if(smooth_code_1) I.Blend(smooth_code_1,ICON_MULTIPLY)

		var/icon/NE = new /icon(icon,"ne")
		if(smooth_code_2) NE.Blend(smooth_code_2,ICON_MULTIPLY)
		I.Blend(NE,ICON_OVERLAY)

		var/icon/SW = new /icon(icon,"sw")
		if(smooth_code_3) SW.Blend(smooth_code_3,ICON_MULTIPLY)
		I.Blend(SW,ICON_OVERLAY)

		var/icon/SE = new /icon(icon,"se")
		if(smooth_code_4) SE.Blend(smooth_code_4,ICON_MULTIPLY)
		I.Blend(SE,ICON_OVERLAY)

		SSturf.icon_cache[full_icon_string] = I

	icon = I
	pixel_x = (TILE_SIZE - I.Width())/2 + initial(pixel_x)
	pixel_y = (TILE_SIZE - I.Height())/2 + initial(pixel_y)

	return TRUE

/turf/simulated/floor/tile/morphing/nanotrasen
	color = COLOR_NANOTRASEN

/turf/simulated/floor/tile/morphing/cryo
	color = COLOR_GREEN

/turf/simulated/floor/tile/morphing/virology
	color = COLOR_GREEN

/turf/simulated/floor/tile/morphing/hydroponics
	color = COLOR_GREEN

/turf/simulated/floor/tile/morphing/mining
	color = COLOR_SCIENCE

/turf/simulated/floor/tile/morphing/medical
	color = COLOR_MEDICAL

/turf/simulated/floor/tile/morphing/science
	color = COLOR_SCIENCE

/turf/simulated/floor/tile/morphing/engineering
	color = COLOR_ENGINEERING

/turf/simulated/floor/tile/morphing/janitor
	color = COLOR_JANITOR

/turf/simulated/floor/tile/morphing/chapel
	color = COLOR_GREY_DARK

/turf/simulated/floor/tile/morphing/library
	color = COLOR_LIBRARY

/turf/simulated/floor/tile/morphing/red
	color = COLOR_RED

/turf/simulated/floor/tile/morphing/pink
	color = "#FFBFEC"

/turf/simulated/floor/tile/morphing/red/dark
	color = COLOR_RED_DARK

/turf/simulated/floor/tile/morphing/blue
	color = COLOR_BLUE

/turf/simulated/floor/tile/morphing/brown
	color = COLOR_BROWN

/turf/simulated/floor/tile/morphing/grey
	color = COLOR_GREY

/turf/simulated/floor/tile/morphing/dark
	color = COLOR_STEEL


/turf/simulated/floor/tile/morphing/green
	color = COLOR_GREEN

/turf/simulated/floor/tile/morphing/yellow
	color = COLOR_YELLOW

/turf/simulated/floor/tile/morphing/yellow/pure
	color = "#FFFF00"

/turf/simulated/floor/tile/morphing/chemistry
	color = COLOR_CHEMISTRY

/turf/simulated/floor/tile/morphing/command
	color = COLOR_COMMAND

/turf/simulated/floor/tile/morphing/cargo
	color = COLOR_CARGO
