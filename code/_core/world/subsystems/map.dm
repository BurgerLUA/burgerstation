SUBSYSTEM_DEF(map)
	name = "Map Subsystem"
	desc = "Initialize the maps for the game."
	priority = SS_ORDER_LAST

	tick_usage_max = 75

	var/list/z_icons = list()

/subsystem/map/Initialize()
	log_subsystem(src.name,"Creating maps...")
	for(var/z=1,z<=world.maxz,z++)
		var/icon/I = ICON_INVISIBLE
		I.Crop(1,1,world.maxx,world.maxy) //Match it to the world size.
		log_subsystem(src.name,"Creating maps of level [z]...")
		for(var/x=1,x<=world.maxx,x++) for(var/y=1,y<=world.maxy,y++)
			CHECK_TICK_HARD(DESIRED_TICK_LIMIT)
			var/turf/simulated/S = locate(x,y,z)
			if(!istype(S))
				continue
			var/found_color
			var/area/A = S.loc
			if(A.map_color) //Mapped out area.
				found_color = A.map_color
				if(S.density && (S.density_north || S.density_east || S.density_west || S.density_south))
					found_color = blend_colors(found_color,"#000000",0.5)
				else if(locate(/obj/structure/table/window) in S.contents)
					found_color = blend_colors(found_color,"#000000",0.4)
			else if(S.map_color)
				found_color = S.map_color
				if(!S.density && S.has_dense_atom)
					found_color = blend_colors(found_color,"#000000",0.25)

			if(!found_color)
				found_color = (x+y)%2 ? "#000000" : "#FF00DC"

			if(!((x+y)%8) && SSdmm_suite.is_pvp_coord(x,y,z))
				found_color = blend_colors(found_color,"#FF0000",0.25)

			I.DrawBox(found_color,x,y)

		z_icons += I

	. = ..()

