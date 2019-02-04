/subsystem/lighting/
	name = "Lighting Subsystem"
	desc = "Controls the lighting."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_LIGHTING

/subsystem/lighting/on_life()
	for(var/client/C in all_clients)

		if(!C.mob)
			continue

		if(C.lighting)
			C.images -= C.lighting
			qdel(C.lighting)

		var/icon/map_color = new('icons/lighting.dmi',"white")

		var/list/mob_mapcolor = C.mob.get_map_color()
		map_color.MapColors(mob_mapcolor["r"],mob_mapcolor["g"],mob_mapcolor["b"],mob_mapcolor["a"])

		var/max_possible = TILE_SIZE*(1+VIEW_RANGE)*2
		map_color.Scale(max_possible,max_possible)

		var/image/I = new /image(map_color)
		I.pixel_x = 16-(max_possible*0.5)
		I.pixel_y = 16-(max_possible*0.5)
		I.loc = C.mob
		I.layer = LAYER_AREA
		I.plane = 12
		I.mouse_opacity = 0
		I.blend_mode = BLEND_MULTIPLY

		C.lighting = I
		C.images += I

	return TRUE