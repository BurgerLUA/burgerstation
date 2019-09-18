/obj/plane_master/
	name = "plane master"
	plane = 0
	appearance_flags = PLANE_MASTER
	screen_loc = "1,1"
	mouse_opacity = 0

/obj/plane_master/walls
	plane = PLANE_WALL

/obj/plane_master/walls/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
	return .