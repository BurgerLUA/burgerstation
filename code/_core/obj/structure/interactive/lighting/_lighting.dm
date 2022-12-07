/obj/structure/interactive/lighting/
	anchored = TRUE
	power_type = POWER_LIGHT
	powered = TRUE //By default.

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

	update_atom_light()
	update_sprite()

	return TRUE



