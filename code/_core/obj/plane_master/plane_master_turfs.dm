
/obj/plane_master/floors
	plane = PLANE_FLOOR
	render_target = "plane_floor"

/obj/plane_master/floors/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))


/obj/plane_master/walls
	plane = PLANE_WALL
	render_target = "plane_wall"

/obj/plane_master/walls/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))

//Exterior areas. For weather effects.
/obj/plane_master/area_exterior
	plane = PLANE_AREA_EXTERIOR
	render_target = "*area_exterior"

/obj/plane_master/area_exterior/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"]) //Exists to add a fade to weather effects.
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))


/obj/plane_master/weather
	plane = PLANE_WEATHER

/obj/plane_master/weather/apply_post_processing()
	. = ..()
	filters += filter(type="alpha", x=0, y=0, render_source="*area_exterior")