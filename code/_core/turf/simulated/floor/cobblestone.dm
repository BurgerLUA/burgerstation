/turf/simulated/floor/cobblestone
	name = "cobblestone"
	icon = 'icons/turf/floor/path.dmi'
	icon_state = "cobble_center"
	color = "#888888"

	layer = LAYER_FLOOR_TILE

	footstep = /footstep/concrete

	destruction_turf = /turf/simulated/floor/colored/dirt

	map_color = COLOR_GREY

	health_base = 200

/turf/simulated/floor/cobblestone/side
	icon_state = "cobble_side"


/turf/simulated/floor/cobblestone/corner
	icon_state = "cobble_corner"


/turf/simulated/floor/brick
	name = "brick floor"
	icon = 'icons/turf/floor/brick_new.dmi'
	icon_state = "0,0"
	color = "#FFFFFF"

	footstep = /footstep/concrete

	destruction_turf = /turf/simulated/floor/colored/dirt

	health_base = 500

/turf/simulated/floor/brick/New(var/desired_loc)
	icon_state = "[x % 10],[y % 10]"
	. = ..()

/turf/simulated/floor/brick/grey
	color = "#728072"

/turf/simulated/floor/brick/red
	color = "#C66B59"

/turf/simulated/floor/brick/grey/dark
	color = COLOR_GREY_DARK

/turf/simulated/floor/brick/grey/dark/ish
	color = "#444444"

/turf/simulated/floor/brick/sand
	color = "#AE8A67"

/turf/simulated/floor/brick/city
	color = "#AF9580"

/turf/simulated/floor/brick/city/clean
	color = "#CCBAAD"

/turf/simulated/floor/temple
	name = "temple floor"
	icon = 'icons/turf/floor/temple.dmi'
	icon_state = "floor"
	color = "#D3B27C"
	destruction_turf = /turf/simulated/floor/plating/reinforced
	health_base = 1000

/turf/simulated/floor/temple/jewel
	icon_state = "floor_jewel"
	destruction_turf = /turf/simulated/floor/circuit/blue

/turf/simulated/floor/temple/jewel/Finalize()
	. = ..()
	update_sprite()

/turf/simulated/floor/temple/jewel/update_icon()
	. = ..()
	icon_state = "floor"

/turf/simulated/floor/temple/jewel/update_overlays()
	. = ..()
	var/image/I = new(initial(icon),"light")
	var/offset_x = rand(0,3) * 8
	var/offset_y = rand(0,3)
	if(offset_y % 2)
		offset_x += 4
	offset_y *= 8
	I.pixel_x = offset_x
	I.pixel_y = offset_y
	add_overlay(I)
	light_offset_x = offset_x - 12
	light_offset_y = offset_y - 12
	set_light(1,0.25,"#C0CBE5")