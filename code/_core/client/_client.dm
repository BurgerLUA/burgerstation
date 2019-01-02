var/global/list/all_clients = list()

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/datum/button_tracker/button_tracker
	var/datum/macros/macros
	fps = FPS_CLIENT
	preload_rsc = 1

	var/list/obj/inventory/known_inventory

	var/zoom_level = 64

	//lazy_eye = 5

/client/New()
	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	all_clients += src

	known_inventory = list()

	src.mob = new /mob/living/advanced/human(pick(spawnpoints))
	src.mob.ckey = ckey
	src.mob.name = "Urist Mc[capitalize(lowertext(ckey))]"
	src.mob.Initialize()

	update_zoom(0)

	generate_HUD()

/client/verb/button_press(button as text)
	set hidden = TRUE
	set instant = TRUE
	button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	set instant = TRUE
	button_tracker.set_released(button)


/client/MouseMove(object,location,control,params) //WARNING: OVERHEAD
	/*
	if(mob)
		mob.face_atom(location)
	*/

/client/MouseWheel(object,delta_x,delta_y,location,control,params)
	var/change_in_screen = clamp(delta_x + delta_y,-1,1)*8
	update_zoom(zoom_level + change_in_screen)


/client/MouseDown(object,location,control,params)

	var/list/aug = params2list(params)

	if("left" in aug)
		mob.on_left_click(object,location,control,aug)

	if("right" in aug)
		mob.on_right_click(object,location,control,aug)

	if("middle" in aug)
		mob.on_middle_click(object,location,control,aug)


/client/proc/update_zoom(var/desired_zoom_level)
	if(desired_zoom_level == 0)
		desired_zoom_level = initial(zoom_level)
	zoom_level = clamp(desired_zoom_level,32,256)
	winset(src, "map.map","icon-size=[zoom_level]")