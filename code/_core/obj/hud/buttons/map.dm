/obj/hud/map
	name = "map"
	icon_state = null
	screen_loc = "CENTER+0.5,CENTER+0.5"

	plane = PLANE_MAP
	layer = LAYER_HUD+11

	mouse_opacity = 1

	var/current_zoom = 3
	var/offset_x = 0
	var/offset_y = 0
	var/current_z = 0

	var/max_x = 0
	var/max_y = 0

	user_colors = FALSE

	var/obj/hud/button/map_background/connected_background

	appearance_flags = NO_CLIENT_COLOR | PIXEL_SCALE | LONG_GLIDE | TILE_BOUND | KEEP_TOGETHER

/obj/hud/map/Destroy()
	. = ..()
	connected_background = null

/obj/hud/map/update_overlays()

	. = ..()

	if(connected_background)
		if(connected_background.linked_pod)
			var/image/I = new/image('icons/hud/hud.dmi',"drop_pod_target")
			I.pixel_x = connected_background.x_drop - 16
			I.pixel_y = connected_background.y_drop - 16
			add_overlay(I)

		for(var/k in all_shuttle_landing_markers)
			var/obj/marker/shuttle_landing/SL = k
			if(SL.z != current_z)
				continue
			if(SL.owning_shuttle)
				continue
			var/desired_icon_state = connected_background.linked_shuttle_controller && SL == connected_background.linked_shuttle_controller.transit_marker_destination ? "shuttle_target" : "shuttle_marker"
			var/image/I = new/image('icons/hud/hud.dmi',desired_icon_state)
			I.pixel_x = SL.x - 16
			I.pixel_y = SL.y - 16
			if(SL.linked_computer)
				I.maptext = "<center><font color='white' style='-dm-text-outline: 1 black'>Landing Zone [SL.linked_computer.shuttle_number]</center>"
			add_overlay(I)

		for(var/k in all_shuttle_controlers)
			var/obj/shuttle_controller/SC = k
			if(SC.z != current_z)
				continue
			if(!SC.stored_icon)
				continue
			var/image/I = new/image(SC.stored_icon)
			I.pixel_x = SC.x - 16
			I.pixel_y = SC.y - 16
			var/area/A = get_area(SC)
			I.maptext = "<center><font color='white' style='-dm-text-outline: 1 black'>[A.name]</center>"
			I.maptext_y = 16
			I.color = COLOR_PINK
			add_overlay(I)


/obj/hud/map/proc/update_map(var/desired_z=0)

	if(desired_z > 0)
		current_z = desired_z
		icon = SSmap.z_icons[current_z]
		name = "map of z [current_z]"

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


/obj/hud/map/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(30)

	. = ..()

	var/x_pos = params[PARAM_ICON_X]
	var/y_pos = params[PARAM_ICON_Y]
	var/z_pos = current_z

	if(connected_background?.linked_shuttle_controller)
		//Find the closet marker.
		var/turf/T = locate(x_pos,y_pos,z_pos)
		var/obj/marker/shuttle_landing/best_marker
		var/obj/marker/shuttle_landing/best_distance = VIEW_RANGE*2
		for(var/k in all_shuttle_landing_markers)
			var/obj/marker/shuttle_landing/SL = k
			if(SL.z != current_z)
				continue
			if(SL.owning_shuttle && SL.owning_shuttle != connected_background.linked_shuttle_controller)
				continue
			var/distance = get_dist(T,SL)
			if(distance > best_distance)
				continue
			best_marker = SL
			best_distance = distance

		if(best_marker && connected_background.linked_shuttle_controller.set_destination(caller,best_marker))
			update_sprite()
			caller.to_chat(span("notice","New shuttle destination selected: [best_marker.name] [best_marker.linked_computer.shuttle_number]."))

		return TRUE


	if(connected_background?.linked_pod)
		var/turf/T = locate(x_pos,y_pos,z_pos)
		if(!T)
			caller.to_chat(span("warning","Error: Invalid location ([x_pos],[y_pos],[z_pos])."))
		else
			var/turf/safe_check = get_step(T,SOUTH)
			if(!safe_check || safe_check.density)
				caller.to_chat(span("warning","Error: Unsafe location."))
			else
				connected_background.x_drop = x_pos
				connected_background.y_drop = y_pos
				connected_background.z_drop = z_pos
				update_sprite()
				caller.to_chat(span("notice","Coords set to: ([x_pos],[y_pos],[z_pos]); Area: [T.loc.name]."))
		return TRUE


	var/turf/T = locate(x_pos,y_pos,z_pos)
	if(!T)
		caller.to_chat(span("warning","Failed to give valid information on coords ([x_pos],[y_pos],[z_pos])."))
	else
		caller.to_chat(span("notice","Coords: ([x_pos],[y_pos],[z_pos]); Area: [T.loc.name]."))
		if(istype(caller,/mob/abstract/observer))
			caller.force_move(T)

/obj/hud/button/map_background
	name = "map background"
	icon = null
	icon_state = null

	plane = PLANE_MAP
	layer = LAYER_HUD+10

	user_colors = TRUE

	var/obj/hud/map/connected_map

	var/list/obj/hud/button/connected_controls = list()

	screen_loc = "LEFT,BOTTOM to RIGHT,TOP"

	alpha = 0

	mouse_opacity = 2

	//Drop Pod Stuff
	var/obj/structure/interactive/drop_pod/linked_pod
	var/x_drop = 0
	var/y_drop = 0
	var/z_drop = 0

	//Shuttle stuff.
	var/obj/shuttle_controller/linked_shuttle_controller

	var/map_z = 2

/obj/hud/button/map_background/clicked_on_by_object(var/mob/caller,var/atom/caller,location,control,params)
	return TRUE

/obj/hud/button/map_background/New(var/desired_loc,var/desired_pod,var/desired_shuttle_controller)

	connected_map = new(desired_loc)
	connected_map.connected_background = src
	connected_controls += new /obj/hud/button/map_control/up(desired_loc)
	connected_controls += new /obj/hud/button/map_control/down(desired_loc)
	connected_controls += new /obj/hud/button/map_control/left(desired_loc)
	connected_controls += new /obj/hud/button/map_control/right(desired_loc)
	connected_controls += new /obj/hud/button/map_control/zoom_in(desired_loc)
	connected_controls += new /obj/hud/button/map_control/zoom_out(desired_loc)
	connected_controls += new /obj/hud/button/map_control/close(desired_loc)

	if(desired_pod)
		linked_pod = desired_pod
		connected_controls += new /obj/hud/button/map_control/launch(desired_loc)

	if(desired_shuttle_controller)
		linked_shuttle_controller = desired_shuttle_controller
		connected_controls += new /obj/hud/button/map_control/launch(desired_loc)
		connected_controls += new /obj/hud/button/map_control/base(desired_loc)


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
			if(linked_pod || linked_shuttle_controller)
				map_z = SSdmm_suite.file_to_z_level["maps/_core/mission.dmm"]
			else
				map_z = T.z

			if(T.z == map_z)
				connected_map.offset_x = T.x
				connected_map.offset_y = T.y
			else
				connected_map.offset_x = round(world.maxx/2,1)
				connected_map.offset_y = round(world.maxx/2,1)

			if(linked_pod)
				x_drop = connected_map.offset_x
				y_drop = connected_map.offset_y
				z_drop = map_z

			connected_map.update_map(map_z)
			connected_map.update_sprite()

		for(var/k in connected_controls)
			var/obj/hud/button/B = k
			B.update_owner(owner)
			if(owner == null)
				connected_controls -= k


/obj/hud/button/map_control/
	name = "map control"
	icon = 'icons/hud/hud.dmi'

	plane = PLANE_HUD
	layer = LAYER_HUD+12

	var/offset_x = 0
	var/offset_y = 0
	var/close = 0
	var/launch = 0

	var/zoom = 0

	var/obj/hud/button/map_background/connected_background

/obj/hud/button/map_control/Destroy()
	. = ..()
	connected_background = null

/obj/hud/button/map_control/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	var/obj/hud/map/M = connected_background?.connected_map

	if(!M || close || launch)

		. = ..()

		if(connected_background.linked_shuttle_controller)
			if(launch && close) //Return to base.
				if(connected_background.linked_shuttle_controller.set_destination(caller,connected_background.linked_shuttle_controller.transit_marker_base) && connected_background.linked_shuttle_controller.start_flight(caller))
					connected_background.update_owner(null)
				return TRUE
			else if(launch) //Go to target.
				if(connected_background.linked_shuttle_controller.start_flight(caller))
					connected_background.update_owner(null)
				return TRUE
			else if(close)
				connected_background.update_owner(null)
				return TRUE

		if(connected_background.linked_pod)
			if(launch)
				var/turf/T = locate(connected_background.x_drop,connected_background.y_drop,connected_background.z_drop)
				if(connected_background.linked_pod.set_state(caller,POD_LAUNCHING,T))
					connected_background.update_owner(null)
				return TRUE
			else if(close)
				connected_background.linked_pod.set_state(caller,POD_IDLE)
				connected_background.update_owner(null)
				return TRUE

		connected_background.update_owner(null)

		return .

	M.offset_x += (offset_x*VIEW_RANGE*3) / M.current_zoom
	M.offset_y += (offset_y*VIEW_RANGE*3) / M.current_zoom
	M.current_zoom += zoom
	M.update_map()

	. = ..()

/obj/hud/button/map_control/close
	name = "close map"
	icon_state = "close"
	close = 1
	screen_loc = "CENTER+3,BOTTOM+2"

/obj/hud/button/map_control/launch
	name = "launch"
	icon_state = "launch"
	launch = 1
	screen_loc = "CENTER-2,BOTTOM+2"

/obj/hud/button/map_control/base
	name = "return to base"
	icon_state = "base"
	launch = 1
	close = 1
	screen_loc = "CENTER-3,BOTTOM+2"

/obj/hud/button/map_control/up
	name = "scroll up"
	icon_state = "arrow"
	dir = NORTH
	offset_y = 1
	screen_loc = "CENTER,BOTTOM+3"

/obj/hud/button/map_control/down
	name = "scroll down"
	icon_state = "arrow"
	dir = SOUTH
	offset_y = -1
	screen_loc = "CENTER,BOTTOM+2"

/obj/hud/button/map_control/right
	name = "scroll right"
	icon_state = "arrow"
	dir = EAST
	offset_x = 1
	screen_loc = "CENTER+1,BOTTOM+2"

/obj/hud/button/map_control/left
	name = "scroll left"
	icon_state = "arrow"
	dir = WEST
	offset_x = -1
	screen_loc = "CENTER-1,BOTTOM+2"

/obj/hud/button/map_control/zoom_in
	name = "zoom in"
	icon_state = "plus"
	dir = NORTH
	zoom = 1
	screen_loc = "CENTER+2,BOTTOM+3"

/obj/hud/button/map_control/zoom_out
	name = "zoom out"
	icon_state = "minus"
	dir = NORTH
	zoom = -1
	screen_loc = "CENTER+2,BOTTOM+2"
