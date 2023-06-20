var/global/list/stored_boss_floor_icons






/turf/simulated/floor/boss/
	name = "ancient floor"

	icon = 'icons/turf/special/boss.dmi'
	icon_state = "boss"

	var/safe = TRUE

	footstep = /footstep/concrete

	layer = -1000

	desired_light_frequency = 2
	desired_light_power = 0.25
	desired_light_range = 4
	desired_light_color = "#CE631C"

	map_color = "#30251C"

	wet_floor_icon_state = "tile"

/turf/simulated/floor/boss/New()
	..()
	if(!stored_boss_floor_icons)
		stored_boss_floor_icons = list()
		for(var/i=1,i<=30,i++)
			CHECK_TICK_HARD
			var/icon/I = ICON_INVISIBLE
			if(prob(60))
				if(prob(80))
					var/icon/N = new /icon(icon,get_quad_icon_state(),NORTH)
					I.Blend(N,ICON_OVERLAY)
				if(prob(80))
					var/icon/E = new /icon(icon,get_quad_icon_state(),EAST)
					I.Blend(E,ICON_OVERLAY)
				if(prob(80))
					var/icon/W = new /icon(icon,get_quad_icon_state(),WEST)
					I.Blend(W,ICON_OVERLAY)
				if(prob(80))
					var/icon/S = new /icon(icon,get_quad_icon_state(),SOUTH)
					I.Blend(S,ICON_OVERLAY)
			else
				if(prob(60))
					var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : SOUTH
					dir_to_use = pick(dir_to_use)
					var/icon/S = new /icon(icon,get_solid_icon_state(),dir_to_use)
					I.Blend(S,ICON_OVERLAY)
				else
					var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : DIRECTIONS_CARDINAL
					dir_to_use = pick(dir_to_use)
					var/icon/D = new /icon(icon,get_donut_icon_state(),dir_to_use)
					I.Blend(D,ICON_OVERLAY)
					if(prob(80))
						var/icon/T = new /icon(icon,get_timbit_icon_state())
						I.Blend(T,ICON_OVERLAY)
			stored_boss_floor_icons += I

/turf/simulated/floor/boss/Finalize()
	. = ..()
	update_sprite()

/turf/simulated/floor/boss/update_overlays()
	. = ..()
	var/image/I = new(icon,icon_state)
	I.icon = pick(stored_boss_floor_icons)
	I.plane = src.plane
	I.layer = 1000
	I.appearance_flags = src.appearance_flags | KEEP_APART
	add_overlay(I)


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
