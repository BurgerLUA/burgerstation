var/global/list/all_clients = list()

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/datum/button_tracker/button_tracker
	var/datum/macros/macros
	fps = FPS_CLIENT
	preload_rsc = 1

	var/list/obj/inventory/known_inventory
	var/list/obj/button/known_buttons

	var/zoom_level = 64

	var/userdata/userdata

	var/save_slot //The character slot that the client wishes to overwrite.

	//lazy_eye = 5

/client/New()
	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	all_clients += src

	known_inventory = list()
	known_buttons = list()

	/*
	if(ckey == "burgerbb")
		src.mob = new /mob/living/advanced/reptile(pick(spawnpoints))
		src.mob.ckey = ckey
		src.mob.name = "Urist Mc[capitalize(lowertext(ckey))]"
		src.mob.Initialize()
	else
		src.mob = new /mob/living/advanced/human(pick(spawnpoints))
		src.mob.ckey = ckey
		src.mob.name = "Urist Mc[capitalize(lowertext(ckey))]"
		src.mob.Initialize()
	*/

	src.mob = new /mob/abstract/observer(pick(observer_spawnpoints),src)
	src.mob.Initialize()
	eye = locate(11,11,src.mob.z)
	view = 8

	var/turf/T = get_turf(src.mob)
	if(T)
		T.on_enter(src.mob)

	if(!userdata)
		userdata = new(src)

	update_zoom(0)

/client/verb/button_press(button as text)
	set hidden = TRUE
	//set instant = TRUE
	button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	//set instant = TRUE
	button_tracker.set_released(button)


/client/MouseMove(object,location,control,params) //WARNING: OVERHEAD
	/*
	if(mob)
		mob.face_atom(location)
	*/

/client/MouseWheel(object,delta_x,delta_y,location,control,params)
	var/change_in_screen = clamp(delta_x + delta_y,-1,1)*8
	update_zoom(zoom_level + change_in_screen)


/client/MouseDown(var/atom/object,location,control,params)

	var/list/aug = params2list(params)

	if(mob.movement_flags & MOVEMENT_WALKING)
		object.examine(mob)
		return

	if("left" in aug)
		mob.on_left_click(object,location,control,aug)

	if("right" in aug)
		mob.on_right_click(object,location,control,aug)

	if("middle" in aug)
		mob.on_middle_click(object,location,control,aug)

/client/proc/update_zoom(var/desired_zoom_level)
	if(eye != mob)
		zoom_level = 64
	else
		if(desired_zoom_level == 0)
			desired_zoom_level = initial(zoom_level)
		zoom_level = clamp(desired_zoom_level,32,256)

	winset(src, "map.map","icon-size=[zoom_level]")

/client/proc/save_current_character()
	userdata.save_current_character()
