//Lighting
/obj/plane_master/lighting
	plane = PLANE_LIGHTING
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = 0
	appearance_flags = PLANE_MASTER | LONG_GLIDE | PIXEL_SCALE | TILE_BOUND | NO_CLIENT_COLOR

//Scenery
/obj/plane_master/scenery
	plane = PLANE_SCENERY
	mouse_opacity = 0

/obj/plane_master/scenery/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=-4, size=3, offset=0, color=rgb(0,0,0,200))
	var/icon/I = new/icon('icons/test.dmi',"reverse")
	filters += filter(type="alpha",icon = I, flags = MASK_INVERSE)

//HUD
/obj/plane_master/hud
	plane = PLANE_HUD
	appearance_flags = PLANE_MASTER | LONG_GLIDE | PIXEL_SCALE | TILE_BOUND | NO_CLIENT_COLOR


/obj/plane_master/hud/apply_post_processing()
	. = ..()
	//Depth
	if(owner?.client?.settings?.loaded_data["enable_depth"])
		filters += filter(type="drop_shadow", x=0, y=0, size=2, offset=0, color=rgb(0,0,0))