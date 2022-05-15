/obj/plane_master/
	name = "plane master"
	icon = null
	plane = 0
	screen_loc = "CENTER" //Stolen from /tg/
	appearance_flags = PLANE_MASTER | PIXEL_SCALE
	blend_mode = BLEND_OVERLAY
	alpha = 255
	var/mob/owner

/obj/plane_master/New(var/desired_loc)
	. = ..()
	owner = desired_loc
	apply_post_processing()

/obj/plane_master/Destroy()
	owner = null
	. = ..()

/obj/plane_master/proc/refresh_post_processing()
	remove_post_processing()
	apply_post_processing()
	return TRUE

/obj/plane_master/proc/remove_post_processing()
	for(var/k in filters)
		filters -= k
	return TRUE

/obj/plane_master/proc/apply_post_processing()
	return TRUE

//FLOORS
/obj/plane_master/floor
	plane = PLANE_FLOOR
	render_target = "plane_floor"

/obj/plane_master/floor/apply_post_processing()
	. = ..()
	//filters += filter(type="radial_blur", size=0.02/VIEW_RANGE)

//WALLS
/obj/plane_master/walls
	plane = PLANE_WALL
	render_target = "plane_wall"

/obj/plane_master/walls/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0,200))

	//filters += filter(type="radial_blur", size= 0.02/VIEW_RANGE)


//WATER SURFACE
/obj/plane_master/water_surface
	plane = PLANE_WATER

/obj/plane_master/water_surface/apply_post_processing()
	. = ..()
	filters += filter(type="alpha", x=0, y=0, render_source="plane_floor", flags=MASK_INVERSE) //Prevent ugly water textures drawing above floors.
	filters += filter(type="alpha", x=0, y=0, render_source="plane_wall", flags=MASK_INVERSE) //Prevent ugly water textures drawing above floors.

//WATER FLOOR
/obj/plane_master/water_floor
	plane = PLANE_WATER_FLOOR
	render_target = "plane_water_floor"

/obj/plane_master/water_floor/apply_post_processing()
	. = ..()
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=-3, offset=0, color=rgb(0,0,0,200))

//MOBS
/obj/plane_master/mobs
	plane = PLANE_MOB

/obj/plane_master/mobs/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=1, size=1, offset=0, color=rgb(200,200,200,120))
		filters += filter(type="drop_shadow", x=0, y=-4, size=3, offset=0, color=rgb(0,0,0,200))
	filters += filter(type="alpha", x=0, y=0, render_source="*plane_water_mask", flags=MASK_INVERSE)



/obj/plane_master/mobs_small
	plane = PLANE_MOB_SMALL

/obj/plane_master/mobs_small/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=1, size=1, offset=0, color=rgb(200,200,200,120))
		filters += filter(type="drop_shadow", x=0, y=-1, size=2, offset=0, color=rgb(0,0,0,200))
	filters += filter(type="alpha", x=0, y=0, render_source="*plane_water_mask", flags=MASK_INVERSE)


/obj/plane_master/mobs_dead
	plane = PLANE_MOB_DEAD

/obj/plane_master/mobs_stealth
	plane = PLANE_MOB_STEALTH
	render_target = "plane_mob_stealth"

/obj/plane_master/mobs_stealth/apply_post_processing()
	. = ..()
	filters += filter(type="alpha",render_source="*fov_\ref[owner]")
	filters += filter(type="alpha", x=0, y=0, render_source="*plane_water_mask", flags=MASK_INVERSE)

//DARKNESS
/obj/plane_master/darkness
	plane = 0

/obj/plane_master/darkness/apply_post_processing()
	. = ..()
	//Smooth Shadows. Disabled for now.
	/*
	if(owner?.client?.settings?.loaded_data["enable_smooth_shadows"])
		var/darkness_size = 2
		filters += filter(type="radial_blur", size=0.05)
		filters += filter(type="drop_shadow", x=darkness_size, y=0, size=darkness_size*3, offset=0, color=rgb(0,0,0,255))
		filters += filter(type="drop_shadow", x=0, y=darkness_size, size=darkness_size*3, offset=0, color=rgb(0,0,0,255))
		filters += filter(type="drop_shadow", x=-darkness_size, y=0, size=darkness_size*3, offset=0, color=rgb(0,0,0,255))
		filters += filter(type="drop_shadow", x=0, y=-darkness_size, size=darkness_size*3, offset=0, color=rgb(0,0,0,255))
	*/


//Objects
/obj/plane_master/objs
	plane = PLANE_OBJ
	mouse_opacity = 1

/obj/plane_master/objs/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=-2, size=2, offset=0, color=rgb(0,0,0))

//SHUTTLE
/obj/plane_master/shuttle
	plane = PLANE_SHUTTLE

/obj/plane_master/shuttle/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))

//Scenery
/obj/plane_master/scenery
	plane = PLANE_SCENERY
	mouse_opacity = 0

/obj/plane_master/scenery/apply_post_processing()
	. = ..()
	var/icon/I = new/icon('icons/test.dmi',"reverse")
	filters += filter(type="alpha",icon = I, flags = MASK_INVERSE)


//Lighting
/obj/plane_master/lighting
	plane = PLANE_LIGHTING
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = 0
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR

//Openspace
/obj/plane_master/openspace
	plane = PLANE_FLOOR_BELOW
	color = "#333333"

/obj/plane_master/openspace/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="outline",size=TILE_SIZE*0.5,color="#000000",flags=OUTLINE_SQUARE)
		filters += filter(type="blur", size=1)
		filters += filter(type="drop_shadow", x=0, y=0, size=-4, offset=0, color=rgb(0,0,0))

//Currency
/obj/plane_master/currency
	plane = PLANE_CURRENCY

/obj/plane_master/currency/apply_post_processing()
	. = ..()
	//Currency bloom
	#if DM_VERSION >= 514
	if(owner?.client?.settings?.loaded_data["enable_currency_bloom"])
		filters += filter(type="bloom",threshold="#888888",size=2,offset=0,alpha=255)
		animate(filters[length(filters)],alpha=150,loop=-1,time=8)
		animate(alpha=255,time=8)
	#endif

//HUD
/obj/plane_master/hud
	plane = PLANE_HUD
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR | PIXEL_SCALE


/obj/plane_master/hud/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=0, color=rgb(0,0,0))

//Exterior areas. For weather effects.
/obj/plane_master/area_exterior
	plane = PLANE_AREA_EXTERIOR
	render_target = "*area_exterior"

/obj/plane_master/area_exterior/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))


/obj/plane_master/weather
	plane = PLANE_WEATHER

/obj/plane_master/weather/apply_post_processing()
	. = ..()
	filters += filter(type="alpha", x=0, y=0, render_source="*area_exterior")


/obj/plane_master/water_mask
	plane = PLANE_MOB_WATER_MASK
	render_target = "*plane_water_mask"

/obj/plane_master/water_mask/apply_post_processing()
	. = ..()
	src.filters += filter(type="alpha", x=0, y=0, render_source="plane_water_floor") //Masks only draw in water.

