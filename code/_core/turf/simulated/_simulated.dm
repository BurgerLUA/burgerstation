/turf/simulated/
	var/real_icon
	var/real_icon_state

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT
	desired_light_range = DEFAULT_RANGE_AMBIENT
	desired_light_color = "#FFFFFF"

	var/list/spawning_data //For mob respawns.

	dynamic_lighting = TRUE

/turf/simulated/destroy()
	spawning_data.Cut()
	return ..()

/turf/simulated/Initialize()
	. = ..()
	update_icon()
	return .

/turf/simulated/New(loc)
	if(real_icon)
		icon = real_icon
	if(real_icon_state)
		icon_state = real_icon_state

	var/area/A = src.loc
	desired_light_power *= A.area_light_power
	spawning_data = list()

	..()

/turf/simulated/update_icon()

	if(!corner_icons)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = direction_to_text(d)
		var/turf/T = get_step(src,d)

		calc_list[dir_to_text] = FALSE //Default

		if(!T)
			calc_list[dir_to_text] = FALSE
			continue

		if(should_smooth_with(T))
			calc_list[dir_to_text] = TRUE
			continue

		for(var/obj/structure/O in T.contents)
			if(!should_smooth_with(O))
				continue
			calc_list[dir_to_text] = TRUE
			break

	var/ne = ""
	var/nw = ""
	var/sw = ""
	var/se = ""

	if(calc_list["north"])
		ne += "n"
		nw += "n"
	if(calc_list["south"])
		se += "s"
		sw += "s"

	if(calc_list["east"])
		ne += "e"
		se += "e"
	if(calc_list["west"])
		nw += "w"
		sw += "w"

	if(nw == "nw" && calc_list["northwest"])
		nw = "f"

	if(ne == "ne" && calc_list["northeast"])
		ne = "f"

	if(sw == "sw" && calc_list["southwest"])
		sw = "f"

	if(se == "se" && calc_list["southeast"])
		se = "f"

	if(!ne) ne = "i"
	if(!nw) nw = "i"
	if(!se) se = "i"
	if(!sw) sw = "i"

	if(opacity && "[nw][ne][sw][se]" == "ffff")
		dynamic_lighting = FALSE

	var/icon/I = new /icon(icon,"1-[nw]")
	//I.Blend(NW,ICON_OVERLAY)

	var/icon/NE = new /icon(icon,"2-[ne]")
	I.Blend(NE,ICON_OVERLAY)

	var/icon/SW = new /icon(icon,"3-[sw]")
	I.Blend(SW,ICON_OVERLAY)

	var/icon/SE = new /icon(icon,"4-[se]")
	I.Blend(SE,ICON_OVERLAY)

	icon = I
	pixel_x = (32 - I.Width())/2
	pixel_y = (32 - I.Height())/2
	layer = initial(layer) + 0.1