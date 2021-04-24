/obj/plane_master/
	name = "plane master"
	icon = 'icons/invisible.dmi'
	icon_state = "0"
	plane = 0
	screen_loc = "CENTER" //Stolen from /tg/
	appearance_flags = PLANE_MASTER | PIXEL_SCALE
	blend_mode = BLEND_OVERLAY
	alpha = 255

/*
/obj/plane_master/render_target
	render_target = "screen"
	plane = 0
*/


/obj/plane_master/floor
	plane = PLANE_FLOOR

/*
/obj/plane_master/floor/New(var/desired_loc)
	. = ..()

	var/matrix/M = matrix()
	M.Scale(1.1,1.1)
	filters += filter(type="layer",render_source="plane_walls",transform=M)

*/

//WALLS
/obj/plane_master/walls
	plane = PLANE_WALL
	//render_target = "plane_walls"

/obj/plane_master/walls/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=-4, size=2, offset=0, color=rgb(0,0,0))

//MOBS
/obj/plane_master/mobs
	plane = PLANE_MOB

/obj/plane_master/mobs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=2, size=1, offset=0, color=rgb(200,200,200,120))
	filters += filter(type="drop_shadow", x=0, y=-1, size=2, offset=0, color=rgb(0,0,0,225))


//DARKNESS
/obj/plane_master/darkness
	plane = PLANE_DARKNESS
	mouse_opacity = 0
	blend_mode = BLEND_MULTIPLY

/obj/plane_master/darkness/New(var/desired_loc)
	. = ..()
	//filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=rgb(0,0,0))

//Objects
/obj/plane_master/objs
	plane = PLANE_OBJ
	mouse_opacity = 1

/obj/plane_master/objs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=-1, size=1, offset=0, color=rgb(0,0,0))

//SHUTTLE
/obj/plane_master/shuttle
	plane = PLANE_SHUTTLE

/obj/plane_master/shuttle/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))

//Scenery
/obj/plane_master/scenery
	plane = PLANE_SCENERY
	mouse_opacity = 0

/obj/plane_master/scenery/New(var/desired_loc)
	. = ..()
	var/icon/I = new/icon('icons/test.dmi',"reverse")
	filters += filter(type="alpha",icon = I, flags = MASK_INVERSE)


//Lighting
/obj/plane_master/lighting
	plane = PLANE_LIGHTING
	blend_mode = BLEND_MULTIPLY
	mouse_opacity = 0
	appearance_flags = PLANE_MASTER|NO_CLIENT_COLOR

/obj/plane_master/openspace
	plane = PLANE_FLOOR_BELOW
	appearance_flags = PLANE_MASTER
	color = "#333333"

/obj/plane_master/openspace/New(var/desired_loc)
	. = ..()
	filters += filter(type="outline",size=TILE_SIZE*0.5,color="#000000",flags=OUTLINE_SQUARE)
	filters += filter(type="blur", size=1)
	filters += filter(type="drop_shadow", x=0, y=0, size=-4, offset=0, color=rgb(0,0,0))

/obj/plane_master/hud
	plane = PLANE_HUD
	appearance_flags = PLANE_MASTER

/obj/plane_master/hud/New(var/desired_loc)
	. = ..()
	filters += filter(type="bloom",threshold="#888888",size=TILE_SIZE*0.5,offset=2,alpha=200)