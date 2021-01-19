/turf/simulated/floor/boss/
	name = "ancient floor"
	icon_state = "floor"
	icon_state = "boss"
	icon = 'icons/turf/special/boss.dmi'
	corner_category = "lava"

	var/under_icon = 'icons/turf/floor/lava.dmi'
	var/under_icon_state = "floor"

	var/seed = 0

	var/safe = TRUE

	footstep = /footstep/concrete

	destruction_turf = /turf/simulated/floor/basalt


/turf/simulated/floor/boss/New()
	..()
	seed = rand(1,9999)

/turf/simulated/floor/boss/update_icon()

	rand_seed(seed)

	var/icon/I = new /icon(under_icon,under_icon_state)

	if(prob(10))
		var/icon/N = new /icon(icon,get_quad_icon_state(),NORTH)
		var/icon/E = new /icon(icon,get_quad_icon_state(),EAST)
		var/icon/W = new /icon(icon,get_quad_icon_state(),WEST)
		var/icon/S = new /icon(icon,get_quad_icon_state(),SOUTH)
		I.Blend(N,ICON_OVERLAY)
		I.Blend(E,ICON_OVERLAY)
		I.Blend(W,ICON_OVERLAY)
		I.Blend(S,ICON_OVERLAY)
	else
		if(rand(1,4))
			var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : SOUTH
			dir_to_use = pick(dir_to_use)
			var/icon/S = new /icon(icon,get_solid_icon_state(),dir_to_use)
			I.Blend(S,ICON_OVERLAY)
		else
			var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : DIRECTIONS_CARDINAL
			dir_to_use = pick(dir_to_use)
			var/icon/D = new /icon(icon,get_donut_icon_state(),dir_to_use)
			I.Blend(D,ICON_OVERLAY)
			if(prob(90))
				var/icon/T = new /icon(icon,get_timbit_icon_state())
				I.Blend(T,ICON_OVERLAY)


	icon = I

/turf/simulated/floor/boss/proc/get_donut_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_surrounding[rand(1,4)]"


/turf/simulated/floor/boss/proc/get_timbit_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_center[rand(1,4)]"

/turf/simulated/floor/boss/proc/get_solid_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_slab[rand(1,4)]"

/turf/simulated/floor/boss/proc/get_quad_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	if(prob(25))
		returning = "[returning]_surrounding_tile[rand(1,2)]"
	else
		returning = "[returning]_tile[rand(1,24)]"

	return returning
