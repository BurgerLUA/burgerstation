/obj/hud/button/map
	name = "map"
	icon_state = null
	screen_loc = "CENTER,CENTER"
	layer = LAYER_HUD
	plane = PLANE_HUD

	user_colors = FALSE

	mouse_opacity = 2

	layer = 9998 //Top

/obj/hud/button/map/New(var/desired_loc)
	screen_loc = "CENTER:-[world.maxx/2],CENTER:-[world.maxy/2]"
	. = ..()

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

	var/current_zoom = 1

	layer = 9999 //Very Top

	var/obj/hud/button/map/connected_map

/obj/hud/button/map_control/Destroy()
	. = ..()
	if(connected_map)
		connected_map.update_owner(null)
		connected_map = null

/obj/hud/button/map_control/New(var/desired_loc)
	screen_loc = "LEFT+2,BOTTOM+2"
	connected_map = new(desired_loc)
	connected_map.screen_loc = "LEFT:[offset_x],BOTTOM:[offset_y] to RIGHT:[offset_x],TOP:[offset_y]"
	. = ..()

/obj/hud/button/map_control/update_owner(var/mob/desired_owner)
	. = ..()
	if(. && connected_map)
		connected_map.update_owner(desired_owner)

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
			offset_x -= TILE_SIZE
		if(21) //Down
			offset_y -= TILE_SIZE
		if(31) //Right
			offset_x += TILE_SIZE
		//Second row up.
		if(22) //Up
			offset_y += TILE_SIZE
		if(32) //Zoom Out
			current_zoom -= 1
		//Third row up.
		if(31)
			update_owner(null)
		if(33) //Zoom In
			current_zoom += 1


	world.log << "Code: [code]."

	offset_x = clamp(offset_x,-TILE_SIZE*VIEW_RANGE,TILE_SIZE*VIEW_RANGE)
	offset_y = clamp(offset_y,-TILE_SIZE*VIEW_RANGE,TILE_SIZE*VIEW_RANGE)
	current_zoom = clamp(current_zoom,1,4)

	var/new_screen_loc = "LEFT:[offset_x],BOTTOM:[offset_y] to RIGHT:[offset_x],TOP:[offset_y]"

	var/matrix/M = matrix()
	M.Scale(current_zoom)
	connected_map.transform = M

	connected_map.screen_loc = new_screen_loc

	world.log << "Zoom: [current_zoom]"

	. = ..()

