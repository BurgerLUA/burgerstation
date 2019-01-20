var/global/list/all_clients = list()

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/datum/button_tracker/button_tracker
	var/datum/macros/macros
	fps = FPS_CLIENT
	preload_rsc = 1

	var/list/obj/inventory/known_inventory
	var/list/obj/button/known_buttons
	var/list/obj/health/known_health_elements

	var/zoom_level = 64

	var/userdata/userdata

	var/save_slot //The character slot that the client wishes to overwrite.


	var/list/last_params = list()
	var/atom/last_object
	var/atom/last_location

	mouse_pointer_icon = 'icons/pointer.dmi'

	//lazy_eye = 5

/client/New()

	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	all_clients += src

	known_inventory = list()
	known_buttons = list()

	var/turf/T = get_turf(src.mob)
	if(T)
		T.on_enter(src.mob)

	if(!userdata)
		userdata = new(src)

	update_zoom(0)

	if(usr) //The only time usr should ever be allowed.
		return ..()

	make_ghost(pick(observer_spawnpoints))

/client/verb/button_press(button as text)
	set hidden = TRUE
	//set instant = TRUE
	button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	//set instant = TRUE
	button_tracker.set_released(button)


/client/proc/make_ghost(var/desired_loc)
	src.mob = new /mob/abstract/observer(desired_loc,src)
	src.mob.Initialize()

/client/MouseMove(object,location,control,params) //WARNING: OVERHEAD
	/*
	if(mob)
		mob.face_atom(location)
	*/
	..()

/client/MouseWheel(object,delta_x,delta_y,location,control,params)
	var/change_in_screen = clamp(delta_x + delta_y,-1,1)*8
	update_zoom(zoom_level + change_in_screen)

	..()

/client/MouseDown(var/atom/object,location,control,params)

	store_new_params(object,location,params)

	var/list/aug = params2list(params)

	if(mob.movement_flags & MOVEMENT_WALKING)
		object.examine(mob)
		return

	if("left" in aug)
		mob.attack_flags |= ATTACK_HELD_LEFT
		mob.on_left_down(object,location,control,aug)

	if("right" in aug)
		mob.attack_flags |= ATTACK_HELD_RIGHT
		mob.on_right_down(object,location,control,aug)

	if("middle" in aug)
		mob.on_middle_down(object,location,control,aug)

	..()


/client/Click(var/atom/object,location,control,params)

	var/list/aug = params2list(params)

	if("left" in aug)
		mob.on_left_click(object,location,control,aug)

	if("right" in aug)
		mob.on_right_click(object,location,control,aug)

	if("middle" in aug)
		mob.on_middle_click(object,location,control,aug)

	..()

/client/MouseUp(object,location,control,params)

	var/list/aug = params2list(params)

	if("left" in aug)
		mob.attack_flags &= ~ATTACK_HELD_LEFT

	if("right" in aug)
		mob.attack_flags &= ~ATTACK_HELD_RIGHT

	..()

/client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)

	if(src_object == over_object)
		return

	var/list/aug = params2list(params)

	if("left" in aug)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if("right" in aug)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if("middle" in aug)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	..()

/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)
	store_new_params(over_object,over_location,params)
	..()

/client/proc/store_new_params(over_object,over_location,params)
	var/list/new_params = params2list(params)
	last_params = new_params
	last_object = over_object
	last_location = over_location

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
