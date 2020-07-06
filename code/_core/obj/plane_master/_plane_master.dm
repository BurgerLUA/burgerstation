/obj/plane_master/
	name = "plane master"
	plane = 0
	screen_loc = "1,1"
	appearance_flags = PLANE_MASTER | LONG_GLIDE | PIXEL_SCALE

/*
/obj/plane_master/render_target
	render_target = "screen"
	plane = 0
*/

//WALLS
/obj/plane_master/walls
	plane = PLANE_WALL

/obj/plane_master/walls/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=-4, size=2, offset=0, color=rgb(0,0,0))
	return .

//MOBS
/obj/plane_master/mobs
	plane = PLANE_MOB

/obj/plane_master/mobs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=2, size=1, offset=0, color=rgb(200,200,200,120))
	filters += filter(type="drop_shadow", x=0, y=-1, size=2, offset=0, color=rgb(0,0,0,225))
	return .


//DARKNESS
/obj/plane_master/darkness
	plane = PLANE_DARKNESS
	mouse_opacity = 1
	blend_mode = BLEND_MULTIPLY

/obj/plane_master/darkness/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=rgb(0,0,0))
	return .

//Objects
/obj/plane_master/objs
	plane = PLANE_OBJ
	mouse_opacity = 1

/obj/plane_master/objs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=-2, size=1, offset=0, color=rgb(0,0,0))
	return .

//SHUTTLE
/obj/plane_master/shuttle
	plane = PLANE_SHUTTLE

/obj/plane_master/shuttle/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
	return .

//Scenery
/obj/plane_master/scenery
	plane = PLANE_SCENERY
	mouse_opacity = 0

/obj/plane_master/scenery/New(var/desired_loc)
	. = ..()
	var/icon/I = new/icon('icons/test.dmi',"reverse")
	filters += filter(type="alpha",icon = I, flags = MASK_INVERSE)
	return .


//Lighting
/obj/plane_master/lighting
	plane = PLANE_LIGHTING
	mouse_opacity = 0

/obj/plane_master/lighting/New(var/desired_loc)
	. = ..()
	//var/icon/I = new/icon('icons/test.dmi',"reverse")
	//filters += filter(type="alpha",icon = I)
	return .