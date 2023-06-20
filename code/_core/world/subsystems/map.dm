SUBSYSTEM_DEF(map)
	name = "Map Subsystem"
	desc = "Initialize the maps for the game."
	priority = SS_ORDER_LAST

	tick_usage_max = 75

	var/list/z_icons = list()

/subsystem/map/Initialize()
	set background = TRUE
	log_subsystem(src.name,"Creating maps...")
	for(var/z=1,z<=world.maxz,z++)
		var/icon/I = ICON_INVISIBLE
		I.Crop(1,1,world.maxx,world.maxy) //Match it to the world size.
		log_subsystem(src.name,"Creating maps of level [z]...")
		for(var/x=1,x<=world.maxx,x++) for(var/y=1,y<=world.maxy,y++)
			CHECK_TICK_HARD
			var/turf/simulated/S = locate(x,y,z)
			if(!S || !is_simulated(S))
				continue
			var/found_color
			var/area/A = S.loc
			var/desired_darkness = 0
			if(A.map_color) //Mapped out colored area (station).
				found_color = A.map_color
				if(!A.map_color_ignore_dense)
					if(S.density && (S.density_north || S.density_east || S.density_west || S.density_south))
						desired_darkness += 0.5
					else if(locate(/obj/structure/table/window) in S.contents)
						desired_darkness += 0.4
			else if(S.map_color)
				found_color = S.map_color
				if(!A.map_color_ignore_dense)
					if(!S.density && S.has_dense_atom) //Dense turfs usually have their own color.
						desired_darkness += 0.25
					if(A.interior)
						desired_darkness += 0.1 //Darken interiors a little.

			if(!found_color)
				found_color = (x+y)%2 ? "#000000" : "#FF00DC"

			if(!((x+y)%8) && SSdmm_suite.is_pvp_coord(x,y,z))
				found_color = blend_colors(found_color,"#FF0000",0.25)

			if(desired_darkness > 0)
				found_color = blend_colors(found_color,"#000000",desired_darkness)

			I.DrawBox(found_color,x,y)

		z_icons += I

	. = ..()

