/client/proc/update_lighting()
	if(!mob)
		return

	if(lighting)
		images -= lighting
		qdel(lighting)

	var/icon/map_color = new('icons/lighting.dmi',"white")

	var/list/mob_mapcolor = mob.get_map_color()
	map_color.MapColors(mob_mapcolor["r"],mob_mapcolor["g"],mob_mapcolor["b"],mob_mapcolor["a"])

	var/max_possible = TILE_SIZE*(1+VIEW_RANGE)*2
	map_color.Scale(max_possible,max_possible)

	var/image/I = new /image(map_color)
	I.pixel_x = 16-(max_possible*0.5)
	I.pixel_y = 16-(max_possible*0.5)
	I.loc = mob
	I.layer = LAYER_AREA
	I.plane = PLANE_LIGHTING_AMBIENT
	I.mouse_opacity = 0
	I.blend_mode = BLEND_MULTIPLY

	lighting = I
	images += I