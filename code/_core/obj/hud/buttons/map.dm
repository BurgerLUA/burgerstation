/obj/hud/button/map
	name = "map"
	icon_state = null
	screen_loc = "CENTER,CENTER"
	layer = LAYER_HUD
	plane = PLANE_HUD

	user_colors = FALSE

	mouse_opacity = 2

	layer = -9998 //Bottom

/obj/hud/button/map/update_icon()
	. = ..()
	if(owner)
		var/turf/T = get_turf(owner)
		if(T && SSmap.z_icons[T.z])
			icon = SSmap.z_icons[T.z]
		else
			log_error("Tried opening map, didn't work...")

/obj/hud/button/map_control
	name = "map controls"
	icon_state = "map_controls"
	mouse_opacity = 1

	var/offset_x = 0
	var/offset_y = 0

	var/current_zoom = 3

	layer = 9998 //Top

	var/obj/hud/button/map/connected_map

/obj/hud/button/map_control/Destroy()
	. = ..()
	if(connected_map)
		connected_map.update_owner(null)
		connected_map = null

/obj/hud/button/map_control/New(var/desired_loc)
	screen_loc = "LEFT+2,BOTTOM+2"
	connected_map = new(desired_loc)
	. = ..()

/obj/hud/button/map_control/update_owner(var/mob/desired_owner)
	. = ..()
	if(. && connected_map)
		connected_map.update_owner(desired_owner)
		if(desired_owner.z)
			offset_x = desired_owner.x
			offset_y = desired_owner.y
		update_map()

/obj/hud/button/map_control/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	var/code = 0 //xy
	//Literally the jankiest shit I wrote in recent memory
	switch(text2num(params[PARAM_ICON_Y]))
		if(2 to 11)
			code += 1
		if(12 to 21)
			code += 2
		if(22 to 31)
			code += 3

	switch(text2num(params[PARAM_ICON_X]))
		if(2 to 11)
			code += 10
		if(12 to 21)
			code += 20
		if(22 to 31)
			code += 30

	switch(code)
		//First Row up.
		if(11) //Left
			offset_x += VIEW_RANGE
		if(21) //Down
			offset_y += VIEW_RANGE
		if(31) //Right
			offset_x -= VIEW_RANGE
		//Second row up.
		if(22) //Up
			offset_y -= VIEW_RANGE
		if(32) //Zoom Out
			current_zoom -= 1
		//Third row up.
		if(31)
			update_owner(null)
		if(33) //Zoom In
			current_zoom += 1


	offset_x = clamp(offset_x,-world.maxx,world.maxx)
	offset_y = clamp(offset_y,-world.maxy,world.maxy)
	current_zoom = clamp(current_zoom,1,4)

	update_map()

	. = ..()



/obj/hud/button/map_control/proc/update_map()

	var/matrix/M = matrix()
	M.Scale(current_zoom,current_zoom)

	var/translate_x = offset_x + (offset_x-world.maxx*0.5)*(current_zoom-1)
	var/translate_y = offset_y + (offset_y-world.maxx*0.5)*(current_zoom-1)

	M.Translate(-translate_x,-translate_y)
	connected_map.transform = M
	connected_map.screen_loc = "CENTER+0.5,CENTER+0.5"

	return TRUE

