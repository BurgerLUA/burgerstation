/obj/hud/map
	name = "map"
	icon_state = null
	screen_loc = "CENTER+0.5,CENTER+0.5"

	plane = PLANE_MAP
	layer = 1

	mouse_opacity = 0

	var/current_zoom = 3
	var/offset_x = 0
	var/offset_y = 0

	var/max_x = 0
	var/max_y = 0

/obj/hud/map/proc/update_map(var/desired_z=0)

	if(desired_z > 0)
		icon = SSmap.z_icons[desired_z]

	current_zoom = round(clamp(current_zoom,1,5),1)
	offset_x = round(clamp(offset_x,0,world.maxx),1)
	offset_y = round(clamp(offset_y,0,world.maxy),1)

	var/matrix/M = matrix()
	M.Scale(current_zoom,current_zoom)

	var/translate_x = -(offset_x + (offset_x-world.maxx*0.5)*(current_zoom-1))
	var/translate_y = -(offset_y + (offset_y-world.maxy*0.5)*(current_zoom-1))

	M.Translate(translate_x,translate_y)
	transform = M

	return TRUE

/obj/hud/button/map_background
	name = "map background"
	icon = null
	icon_state = null

	plane = PLANE_MAP
	layer = 0

	user_colors = TRUE

	var/obj/hud/map/connected_map

	var/list/obj/hud/button/connected_controls = list()

	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

	alpha = 0

	mouse_opacity = 2

/obj/hud/button/map_background/clicked_on_by_object(var/mob/caller,var/atom/caller,location,control,params)
	update_owner(null)
	return TRUE

/obj/hud/button/map_background/New(var/desired_loc)

	connected_map = new(desired_loc)

	connected_controls += new /obj/hud/button/map_control/up(desired_loc)
	connected_controls += new /obj/hud/button/map_control/down(desired_loc)
	connected_controls += new /obj/hud/button/map_control/left(desired_loc)
	connected_controls += new /obj/hud/button/map_control/right(desired_loc)
	connected_controls += new /obj/hud/button/map_control/zoom_in(desired_loc)
	connected_controls += new /obj/hud/button/map_control/zoom_out(desired_loc)
	connected_controls += new /obj/hud/button/map_control/close(desired_loc)

	for(var/k in connected_controls)
		var/obj/hud/button/map_control/B = k
		B.connected_background = src

	. = ..()

/obj/hud/button/map_background/update_owner(var/mob/desired_owner)

	. = ..()

	if(.)
		connected_map.update_owner(owner)
		if(owner == null)
			connected_map = null
		else
			var/turf/T = get_turf(owner)
			connected_map.offset_x = T.x
			connected_map.offset_y = T.y
			connected_map.update_map(T.z)

		for(var/k in connected_controls)
			var/obj/hud/button/B = k
			B.update_owner(owner)
			if(owner == null)
				connected_controls -= k

/obj/hud/button/map_control/
	name = "map control"
	icon = 'icons/hud/hud.dmi'

	plane = PLANE_HUD
	layer = LAYER_HUD + 1

	var/offset_x = 0
	var/offset_y = 0
	var/close = 0

	var/zoom = 0

	var/obj/hud/button/map_background/connected_background

/obj/hud/button/map_control/Destroy()
	. = ..()
	connected_background = null

/obj/hud/button/map_control/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	var/obj/hud/map/M = connected_background?.connected_map

	if(!M || close)
		. = ..()
		M.update_owner(null)
		return .

	var/turf/T = get_turf(caller)
	M.offset_x += (offset_x*VIEW_RANGE*3) / M.current_zoom
	M.offset_y += (offset_y*VIEW_RANGE*3) / M.current_zoom
	M.current_zoom += zoom
	M.update_map(T.z)

	. = ..()

/obj/hud/button/map_control/close
	name = "close map"
	icon_state = "close"
	close = 1
	screen_loc = "CENTER+5,CENTER-4"

/obj/hud/button/map_control/up
	name = "scroll up"
	icon_state = "arrow"
	dir = NORTH
	offset_y = 1
	screen_loc = "CENTER,CENTER-4"

/obj/hud/button/map_control/down
	name = "scroll down"
	icon_state = "arrow"
	dir = SOUTH
	offset_y = -1
	screen_loc = "CENTER,CENTER-5"

/obj/hud/button/map_control/right
	name = "scroll right"
	icon_state = "arrow"
	dir = EAST
	offset_x = 1
	screen_loc = "CENTER+1,CENTER-5"

/obj/hud/button/map_control/left
	name = "scroll left"
	icon_state = "arrow"
	dir = WEST
	offset_x = -1
	screen_loc = "CENTER-1,CENTER-5"

/obj/hud/button/map_control/zoom_in
	name = "zoom in"
	icon_state = "plus"
	dir = NORTH
	zoom = 1
	screen_loc = "CENTER+2,CENTER-4"

/obj/hud/button/map_control/zoom_out
	name = "zoom out"
	icon_state = "minus"
	dir = NORTH
	zoom = -1
	screen_loc = "CENTER+2,CENTER-5"