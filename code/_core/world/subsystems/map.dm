SUBSYSTEM_DEF(map)
	name = "Map Subsystem"
	desc = "Initialize the maps for the game."
	priority = SS_ORDER_LAST

	cpu_usage_max = 75
	tick_usage_max = 75

	var/list/z_icons = list()

/subsystem/map/Initialize()
	set background = 1
	log_subsystem(src.name,"Creating maps...")
	for(var/z=1,z<=world.maxz,z++)
		var/icon/I = ICON_INVISIBLE
		I.Crop(1,1,world.maxx,world.maxy) //Match it to the world size.
		log_subsystem(src.name,"Creating maps of level [z]...")
		for(var/x=1,x<=world.maxx,x++) for(var/y=1,y<=world.maxy,y++)
			var/turf/simulated/S = locate(x,y,z)
			if(!istype(S))
				continue
			var/area/A = S.loc

			var/found_color
			if(A.map_color)
				found_color = A.map_color
			else if(S.map_color)
				found_color = S.map_color

			if(found_color)
				if(S.density && (S.density_north || S.density_east || S.density_west || S.density_south))
					found_color = blend_colors(found_color,"#000000",0.25)
				else if(S.has_dense_atom)
					found_color = blend_colors(found_color,"#000000",0.1)


			if(!found_color)
				found_color = (x+y)%2 ? "#000000" : "#FF00DC"

			I.DrawBox(found_color,x,y)

			sleep(-1)

		z_icons += I

	. = ..()

