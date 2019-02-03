var/global/list/all_clients = list()

#define LP(str) list2params(list(str))

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/button_tracker/button_tracker
	var/macros/macros
	fps = FPS_CLIENT
	preload_rsc = 1

	var/list/obj/inventory/known_inventory
	var/list/obj/button/known_buttons
	var/list/obj/health/known_health_elements

	var/zoom_level = TILE_SIZE * 2

	var/userdata/userdata

	var/save_slot //The character slot that the client wishes to overwrite.


	var/list/last_params = list()
	var/atom/last_object
	var/atom/last_location

	mouse_pointer_icon = 'icons/pointer.dmi'

	var/swap_mouse = FALSE

	//lazy_eye = 5

/client/proc/reset()
	known_inventory = list()
	known_buttons = list()
	known_health_elements = list()
	screen = list()

/client/New()

	world.update_status()

	broadcast("[ckey] has joined the game.")

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

	//update_zoom(0)

	if(usr) //The only time usr should ever be allowed.
		return ..()

	welcome()

	make_ghost(pick(observer_spawnpoints))

/client/proc/welcome()
	src << "<title>Welcome to Burgerstation 13</title>"
	src << "This is a work in progress server for testing out currently working features and other memes. Absolutely anything and everything will end up being changed."
	src << "If you wish to join the discord, please do so here: https://discord.gg/yEaV92a"

/client/Del()
	all_clients -= src
	world.update_status()
	..()


/client/Topic(href,href_list)
	..()

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

/client/verb/change_click_mode()
	set name = "Swap Click Mode"
	set category = "Preferences"
	swap_mouse = !swap_mouse
	if(swap_mouse)
		src << "Right clicking will now activate the object in your right hand, and vice versa."
	else
		src << "Left clicking will now activate the object in your right hand, and vice versa."

/client/proc/get_actual_click_flags(aug)

	var/returning = 0x0
	if(swap_mouse ? ("left" in aug) :("right" in aug))
		returning |= CLICK_RIGHT

	if(swap_mouse ? ("right" in aug) : ("left" in aug))
		returning |= CLICK_LEFT

	if("middle" in aug)
		returning |= CLICK_MIDDLE

	return returning

/client/MouseDown(var/atom/object,location,control,params)

	store_new_params(object,location,params)

	var/list/aug = params2list(params)
	var/click_flags = get_actual_click_flags(aug)

	/*
	if(mob.movement_flags & MOVEMENT_WALKING)
		object.examine(mob)
		return
	*/



	if(click_flags & CLICK_LEFT)
		mob.attack_flags |= ATTACK_HELD_LEFT
		mob.on_left_down(object,location,control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.attack_flags |= ATTACK_HELD_RIGHT
		mob.on_right_down(object,location,control,aug)

	if(click_flags & CLICK_MIDDLE)
		//mob.on_middle_down(object,location,control,aug)
		object.examine(mob)
		return

	..()


/client/Click(var/atom/object,location,control,params)

	var/list/aug = params2list(params)
	var/click_flags = get_actual_click_flags(aug)

	if(click_flags & CLICK_LEFT)
		mob.on_left_click(object,location,control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_click(object,location,control,aug)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_click(object,location,control,aug)

	..()

/client/MouseUp(object,location,control,params)

	var/list/aug = params2list(params)
	var/click_flags = get_actual_click_flags(aug)

	if(click_flags & CLICK_LEFT)
		mob.attack_flags &= ~ATTACK_HELD_LEFT

	if(click_flags & CLICK_RIGHT)
		mob.attack_flags &= ~ATTACK_HELD_RIGHT

	..()

/client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)

	if(src_object == over_object)
		return

	var/list/aug = params2list(params)
	var/click_flags = get_actual_click_flags(aug)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_MIDDLE)
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
		zoom_level = TILE_SIZE
	else
		if(desired_zoom_level == 0)
			desired_zoom_level = initial(zoom_level)
		zoom_level = clamp(desired_zoom_level,TILE_SIZE,TILE_SIZE*4)

	winset(src, "map.map","icon-size=[zoom_level];zoom-mode=normal")

/client/proc/save_current_character()
	userdata.save_current_character()
