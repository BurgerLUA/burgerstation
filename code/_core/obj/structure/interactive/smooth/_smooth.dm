obj/structure/smooth/
	name = "smooth jazz"
	desc = "What does it do?"
	icon_state = "table"

	var/material_id = /material/steel
	var/reinforced_material_id = null
	var/reinforced_color = "#FFFFFF"

	var/debug = FALSE

obj/structure/smooth/PostInitialize()
	. = ..()
	update_sprite()

obj/structure/smooth/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(!corner_icons)
		return ..()

	var/list/calc_list = list()

	for(var/d in DIRECTIONS_ALL)
		var/dir_to_text = "[d]"
		calc_list[dir_to_text] = FALSE
		var/turf/T = get_step(src,d)
		if(!T)
			continue
		if(should_smooth_with(T))
			calc_list[dir_to_text] = TRUE
			continue

	var/ne = ""
	var/nw = ""
	var/sw = ""
	var/se = ""

	if(calc_list["[NORTH]"])
		ne += "n"
		nw += "n"
	if(calc_list["[SOUTH]"])
		se += "s"
		sw += "s"

	if(calc_list["[EAST]"])
		ne += "e"
		se += "e"
	if(calc_list["[WEST]"])
		nw += "w"
		sw += "w"

	if(nw == "nw" && calc_list["[NORTHWEST]"])
		nw = "f"

	if(ne == "ne" && calc_list["[NORTHEAST]"])
		ne = "f"

	if(sw == "sw" && calc_list["[SOUTHWEST]"])
		sw = "f"

	if(se == "se" && calc_list["[SOUTHEAST]"])
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

/obj/structure/smooth/update_overlays()

	. = ..()

	if(reinforced_material_id)
		var/image/I = new/image(initial(icon),"ref")
		I.appearance_flags = RESET_COLOR
		I.color = reinforced_color
		I.alpha = 100
		add_overlay(I)


