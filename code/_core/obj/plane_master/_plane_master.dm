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
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
	return .

//MOBS
/obj/plane_master/mobs
	plane = PLANE_MOB

/obj/plane_master/mobs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
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


//TREES
/obj/plane_master/trees
	plane = PLANE_TREE
	mouse_opacity = 1
	blend_mode = BLEND_MULTIPLY

/obj/plane_master/trees/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=4, y=4, size=6, offset=0, color=rgb(0,0,0))
	return .