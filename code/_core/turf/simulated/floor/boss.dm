






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

/turf/simulated/floor/boss/Finalize()
	. = ..()
	update_sprite()

/turf/simulated/floor/boss/update_overlays()
	. = ..()
	var/image/I = new(icon,icon_state)
	I.icon = pick(SSturf.stored_boss_floor_icons)
	I.plane = src.plane
	I.layer = 1000
	I.appearance_flags = src.appearance_flags | KEEP_APART
	add_overlay(I)
