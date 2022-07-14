/obj/structure/interactive/lighting/
	var/on = TRUE
	anchored = TRUE

/obj/structure/interactive/lighting/Destroy()
	if(apc_powered && src.z)
		var/area/A = loc.loc
		if(A.requires_power)
			update_power_draw(0)
			A.powered_lights -= src

	. = ..()

/obj/structure/interactive/lighting/Finalize()
	. = ..()
	if(apc_powered && src.z)
		var/area/A = loc.loc
		if(A.requires_power)
			A.powered_lights |= src
			on = FALSE
		else
			apc_powered = FALSE

/obj/structure/interactive/lighting/post_move(var/atom/old_loc)
	. = ..()
	if(apc_powered)
		if(isturf(old_loc))
			var/area/A = old_loc.loc
			if(A.requires_power)
				update_power_draw(0)
				A.powered_lights -= src
		if(src.z)
			var/area/A = loc.loc
			if(A.requires_power)
				A.powered_lights |= src
			else
				apc_powered = FALSE

/obj/structure/interactive/lighting/get_power_draw()
	return CEILING(desired_light_power*desired_light_range*30,1)

/obj/structure/interactive/lighting/update_power_draw(var/desired_power_draw,var/reset=FALSE)

	var/area/A = null

	A = get_area(src)
	if(!A.linked_apc)
		desired_power_draw = 0
	if(!A.requires_power)
		desired_power_draw = 0

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		if(!reset) A.power_draw -= power_draw
		power_draw = desired_power_draw
		A.power_draw += power_draw

	return TRUE



