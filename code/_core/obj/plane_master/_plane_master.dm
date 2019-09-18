/obj/plane_master/
	name = "plane master"
	plane = 0
	screen_loc = "1,1"
	appearance_flags = PLANE_MASTER

/obj/plane_master/walls
	plane = PLANE_FLOOR

/obj/plane_master/walls/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
	return .

/obj/plane_master/mobs
	plane = PLANE_MOB

/obj/plane_master/mobs/New(var/desired_loc)
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=4, offset=0, color=rgb(0,0,0))
	return .

