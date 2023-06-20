/turf/simulated/proc/should_smooth_with(var/turf/simulated/T)

	if(!is_simulated(T))
		return null

	if(corner_category)

		if(T.plane == plane && T.corner_category == corner_category)
			return T

	return null

/turf/simulated/wall/should_smooth_with(var/turf/simulated/T)

	. = ..()

	if(.)
		return .

	for(var/obj/structure/O in T.contents)
		if(O.corner_category != corner_category)
			continue
		if(O.plane != plane)
			continue
		return O


/turf/simulated/proc/update_smooth_code()

	if(!corner_icons)
		return FALSE

	var/turf/T_n = get_step(src,NORTH)
	var/calc_n = !T_n || should_smooth_with(T_n)

	var/turf/T_e = get_step(src,EAST)
	var/calc_e = !T_e || should_smooth_with(T_e)

	var/turf/T_s = get_step(src,SOUTH)
	var/calc_s = !T_s || should_smooth_with(T_s)

	var/turf/T_w = get_step(src,WEST)
	var/calc_w = !T_w || should_smooth_with(T_w)

	var/ne
	var/nw
	var/sw
	var/se

	//nw
	if(calc_n && calc_w)
		var/turf/T_nw = get_step(src,NORTHWEST)
		var/calc_nw = !T_nw || should_smooth_with(T_nw)
		if(calc_nw)
			nw = "f"
		else
			nw = "nw"
	else if(calc_w)
		nw = "w"
	else if(calc_n)
		nw = "n"
	else
		nw = "i"

	//ne
	if(calc_n && calc_e)
		var/turf/T_ne = get_step(src,NORTHEAST)
		var/calc_ne = !T_ne || should_smooth_with(T_ne)
		if(calc_ne)
			ne = "f"
		else
			ne = "ne"
	else if(calc_e)
		ne = "e"
	else if(calc_n)
		ne = "n"
	else
		ne = "i"

	//sw
	if(calc_s && calc_w)
		var/turf/T_sw = get_step(src,SOUTHWEST)
		var/calc_sw = !T_sw || should_smooth_with(T_sw)
		if(calc_sw)
			sw = "f"
		else
			sw = "sw"
	else if(calc_w)
		sw = "w"
	else if(calc_s)
		sw = "s"
	else
		sw = "i"

	//se
	if(calc_s && calc_e)
		var/turf/T_se = get_step(src,SOUTHEAST)
		var/calc_se = !T_se || should_smooth_with(T_se)
		if(calc_se)
			se = "f"
		else
			se = "se"
	else if(calc_e)
		se = "e"
	else if(calc_s)
		se = "s"
	else
		se = "i"

	. = FALSE

	if(smooth_code_1 != nw)
		smooth_code_1 = nw
		. = TRUE

	if(smooth_code_2 != ne)
		smooth_code_2 = ne
		. = TRUE

	if(smooth_code_3 != sw)
		smooth_code_3 = sw
		. = TRUE

	if(smooth_code_4 != se)
		smooth_code_4 = se
		. = TRUE

	if(.)
		update_sprite()