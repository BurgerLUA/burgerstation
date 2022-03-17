/obj/structure/interactive/lighting/
	var/lightswitch = FALSE //Set to true if it can be controlled by a lightswitch.
	var/on = TRUE
	var/uses_power = FALSE //If the lightswitch actually uses power to give light.
	var/power_draw = 0
	anchored = TRUE

/obj/structure/interactive/lighting/Destroy()
	if(uses_power && isturf(loc))
		var/area/A = loc.loc
		if(A.requires_power)
			update_power_draw(0)
			A.powered_lights -= src

	. = ..()

/obj/structure/interactive/lighting/Finalize()
	. = ..()
	if(uses_power && isturf(loc))
		var/area/A = loc.loc
		if(A.requires_power)
			A.powered_lights |= src
			on = FALSE
		else
			uses_power = FALSE

/obj/structure/interactive/lighting/post_move(var/atom/old_loc)
	. = ..()
	if(uses_power)
		if(isturf(old_loc))
			var/area/A = old_loc.loc
			if(A.requires_power)
				update_power_draw(0)
				A.powered_lights -= src
		if(isturf(loc))
			var/area/A = loc.loc
			if(A.requires_power)
				A.powered_lights |= src
			else
				uses_power = FALSE

/obj/structure/interactive/lighting/proc/get_power_draw()
	return CEILING(desired_light_power*desired_light_range,1)

/obj/structure/interactive/lighting/proc/update_power_draw(var/desired_power_draw,var/reset=FALSE)

	var/area/A = null

	A = get_area(src)
	if(!A.apc)
		power_draw = -1
		CRASH("Tried updating power draw without a connected APC!")
	if(!A.requires_power)
		power_draw = -1
		CRASH("Tried updating power draw in an area that doesnt' require power!")

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		if(!reset) A.power_draw -= power_draw
		power_draw = desired_power_draw
		A.power_draw += power_draw

	return TRUE



