obj/structure/smooth/
	name = "smooth jazz"
	desc = "What does it do?"
	icon_state = "table"

	var/material_id = "glass"
	var/reinforced_material_id = null
	var/reinforced_color = "#FFFFFF"

obj/structure/smooth/Initialize()
	. = ..()
	update_icon()
	return .

obj/structure/smooth/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(!corner_icons)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = direction_to_text(d)
		calc_list[dir_to_text] = FALSE
		var/turf/T = get_step(src,d)
		if(!T)
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

	var/icon/I = ICON_INVISIBLE

	var/icon/NW = new /icon(icon,"1-[nw]")
	I.Blend(NW,ICON_OVERLAY)

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

	if(reinforced_material_id)
		overlays.Cut()
		var/image/I2 = new/image(initial(icon),"ref")
		I2.color = "#888888"
		I2.alpha = 200
		overlays += I2