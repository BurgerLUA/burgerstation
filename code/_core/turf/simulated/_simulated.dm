var/global/list/turf_icon_cache = list()
var/global/saved_icons = 0


/turf/simulated/

	var/real_icon
	var/real_icon_state

	desired_light_power = DEFAULT_BRIGHTNESS_AMBIENT
	desired_light_range = DEFAULT_RANGE_AMBIENT
	desired_light_color = "#FFFFFF"

	dynamic_lighting = TRUE

	var/fade = FALSE

	var/tile = FALSE //Set to true if this is a tile.

	var/turf/destruction_turf
	health = null
	health_base = 100

	var/reinforced_material_id
	var/reinforced_color


/turf/proc/is_occupied()

	for(var/atom/movable/A in contents)
		if(istype(A,/obj/effect/temp/construction/))
			return A
		if(is_living(A))
			return A
		if(is_structure(A))
			return A

	return FALSE

/turf/simulated/New(var/atom/desired_loc)

	if(real_icon)
		icon = real_icon
	if(real_icon_state)
		icon_state = real_icon_state

	var/area/A = loc

	if(!A.safe)
		if(!destruction_turf)
			if(desired_loc && desired_loc.type != src.type && is_floor(desired_loc))
				destruction_turf = desired_loc.type
			else if(A.destruction_turf != src.type)
				destruction_turf = A.destruction_turf

		if(destruction_turf)
			health = /health/turf/

	desired_light_power *= A.area_light_power

	return ..()

/turf/simulated/can_be_attacked(var/atom/attacker)

	if(!health)
		return FALSE

	var/area/A = get_area(src)
	if(A.safe)
		return FALSE

	return TRUE


/turf/simulated/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/list/damage_table,var/damage_amount)

	. = ..()

	if(destruction_turf && damage_amount >= 0)
		new/obj/effect/temp/damage_number(src,60,damage_amount)

	return .

/turf/simulated/on_destruction(var/atom/caller,var/damage = FALSE)

	if(!destruction_turf)
		LOG_ERROR("ERROR! [src.type] called on_destruction without having a destruction turf!")
		return FALSE

	pixel_x = 0
	pixel_y = 0

	change_turf(destruction_turf)

	update_edges()
	Initialize()

	return ..()

/turf/simulated/Initialize()
	. = ..()
	update_icon()
	return .

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

	if(!tile)
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

	/*
	if(opacity && "[nw][ne][sw][se]" == "ffff")
		dynamic_lighting = FALSE
		icon = 'icons/debug/turfs.dmi'
		icon_state = "black"
		plane = PLANE_ALWAYS_VISIBLE
		return FALSE
	*/

	var/full_icon_string = "[type]_[ne][nw][se][sw]"

	var/icon/I

	if(turf_icon_cache[full_icon_string])
		I = turf_icon_cache[full_icon_string]
		saved_icons++
	else
		I = new /icon(icon,"1-[nw]")

		var/icon/NE = new /icon(icon,"2-[ne]")
		I.Blend(NE,ICON_OVERLAY)

		var/icon/SW = new /icon(icon,"3-[sw]")
		I.Blend(SW,ICON_OVERLAY)

		var/icon/SE = new /icon(icon,"4-[se]")
		I.Blend(SE,ICON_OVERLAY)

		if(fade)
			var/icon/A = new /icon(icon,"fade")
			I.Blend(A,ICON_MULTIPLY)

		turf_icon_cache[full_icon_string] = I

	icon = I
	pixel_x = (32 - I.Width())/2
	pixel_y = (32 - I.Height())/2
	layer = initial(layer) + 0.1

	if(reinforced_material_id)
		overlays.Cut()
		var/image/I2 = new/image(initial(icon),"ref")
		//I.color = reinforced_color
		overlays += I2
