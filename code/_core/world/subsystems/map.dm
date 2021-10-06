SUBSYSTEM_DEF(map)
	name = "Map Subsystem"
	desc = "Initialize the maps for the game."
	priority = SS_ORDER_LAST

	cpu_usage_max = 75
	tick_usage_max = 75

	var/list/z_icons = list()

/subsystem/map/Initialize()
	. = ..()
	log_subsystem(src.name,"Creating maps...")
	for(var/z=1,z<=world.maxz,z++)
		var/icon/I = new/icon('icons/map_template.dmi',"template")
		log_subsystem(src.name,"Creating maps of level [z]...")
		for(var/x=1,x<=world.maxx,x++)
			for(var/y=1,y<=world.maxy,y++)
				var/turf/simulated/S = locate(x,y,z)
				if(!istype(S))
					continue
				var/area/A = S.loc

				var/real_map_color = S.map_color
				var/real_area_color = A.map_color


				if(real_map_color && S.density && (S.density_north || S.density_east || S.density_west || S.density_south))
					real_map_color = blend_colors(real_map_color,"#000000",0.5)

				var/found_color
				if(real_area_color && real_map_color)
					found_color = blend_colors(real_area_color,real_map_color,0.5)
				else if(real_area_color)
					found_color = real_area_color
				else if(real_map_color)
					found_color = real_map_color


				if(found_color) I.DrawBox(found_color,x,y)
				CHECK_TICK(tick_usage_max,FPS_SERVER)
		I.Scale(world.maxx*2,world.maxy*2)
		z_icons += I

