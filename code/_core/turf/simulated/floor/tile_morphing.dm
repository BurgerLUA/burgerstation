/turf/simulated/floor/tile/morphing/
	icon = 'icons/turf/floor/tile_morphing.dmi'
	icon_state = "floor"
	var/original_color
	corner_icons = TRUE

/turf/simulated/floor/tile/morphing/should_smooth_with(var/turf/T)
	return istype(T,/turf/simulated/floor/tile/) && !istype(T,/turf/simulated/floor/tile/morphing)

/turf/simulated/floor/tile/morphing/Initialize()
	original_color = color ? color : "#FFFFFF"
	return ..()

/turf/simulated/floor/tile/morphing/smooth_turfs()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = "[d]"
		var/turf/T = get_step(src,d)

		calc_list[dir_to_text] = FALSE //Default

		if(!T)
			calc_list[dir_to_text] = FALSE
			continue

		if(should_smooth_with(T))
			calc_list[dir_to_text] = T.color ? T.color : "#FFFFFF"
			continue

	var/ne = 0
	var/nw = 0
	var/sw = 0
	var/se = 0

	if(calc_list["[NORTH]"])
		ne = calc_list["[NORTH]"]
		nw = calc_list["[NORTH]"]
	if(calc_list["[SOUTH]"])
		se = calc_list["[SOUTH]"]
		sw = calc_list["[SOUTH]"]
	if(calc_list["[EAST]"])
		ne = calc_list["[EAST]"]
		se = calc_list["[EAST]"]
	if(calc_list["[WEST]"])
		nw = calc_list["[WEST]"]
		sw = calc_list["[WEST]"]

	if(calc_list["[NORTHEAST]"])
		ne = calc_list["[NORTHEAST]"]
	if(calc_list["[SOUTHEAST]"])
		se = calc_list["[SOUTHEAST]"]
	if(calc_list["[NORTHWEST]"])
		nw = calc_list["[NORTHWEST]"]
	if(calc_list["[SOUTHWEST]"])
		sw = calc_list["[SOUTHWEST]"]

	if(!ne & !nw & !sw & !se)
		color = original_color
		return TRUE

	color = "#FFFFFF"

	var/full_icon_string = "[type]_[ne]_[nw]_[se]_[sw]"

	var/icon/I

	if(turf_icon_cache[full_icon_string])
		I = turf_icon_cache[full_icon_string]
		saved_icons++
	else
		I = new /icon(icon,"floor")
		I.Blend(original_color,ICON_MULTIPLY)

		if(ne)
			var/icon/NE = new /icon(icon,"ne")
			NE.Blend(ne,ICON_MULTIPLY)
			I.Blend(NE,ICON_OVERLAY)

		if(nw)
			var/icon/NW = new /icon(icon,"nw")
			NW.Blend(nw,ICON_MULTIPLY)
			I.Blend(NW,ICON_OVERLAY)

		if(se)
			var/icon/SE = new /icon(icon,"se")
			SE.Blend(se,ICON_MULTIPLY)
			I.Blend(SE,ICON_OVERLAY)

		if(sw)
			var/icon/SW = new /icon(icon,"sw")
			SW.Blend(sw,ICON_MULTIPLY)
			I.Blend(SW,ICON_OVERLAY)

		turf_icon_cache[full_icon_string] = I

	icon = I

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
