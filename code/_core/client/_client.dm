var/global/list/all_clients = list()

#define string2params(str) list2params(list(str))

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/button_tracker/button_tracker
	var/macros/macros

	fps = FPS_CLIENT
	preload_rsc = 2

	var/list/obj/hud/inventory/known_inventory
	var/list/obj/hud/button/known_buttons
	var/list/obj/hud/button/known_health_elements

	var/zoom_level = MIN_ZOOM

	var/savedata/client/mob/savedata
	var/savedata/client/connection_history/connection_data
	var/savedata/client/roles/roles
	var/savedata/client/settings/settings

	var/save_slot //The character slot that the client wishes to overwrite.
	var/list/last_params = list()
	var/atom/last_object
	var/atom/last_location

	mouse_pointer_icon = 'icons/pointer.dmi'

	var/swap_mouse = FALSE

	var/image/lighting

	//lazy_eye = 5

	var/karma = 1000

	perspective = EYE_PERSPECTIVE

	var/last_ooc = 0

	var/current_music_track //Id of music track that last played.
	var/next_music_track = 0 //When the next music track should be triggered.

	var/disable_controls = FALSE

	var/is_zoomed = FALSE

	var/next_allowed_topic = -1

	var/update_stats = FALSE

/client/proc/setup_stylesheets()
	winset(src,"chat_all.output","style='[STYLESHEET]'")
	winset(src,"chat_combat.output","style='[STYLESHEET]'")
	winset(src,"chat_looc.output","style='[STYLESHEET]'")
	winset(src,"chat_ooc.output","style='[STYLESHEET]'")
	winset(src,"chat_say.output","style='[STYLESHEET]'")

/client/proc/examine(var/atom/object)
	src.mob.to_chat(object.get_examine_text(src.mob))
	return TRUE

/client/proc/reset()
	known_inventory = list()
	known_buttons = list()
	known_health_elements = list()
	screen = list()
	//update_lighting()

/client/New()

	all_clients += src

	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	if(!roles)
		roles = new(src)

	if(!settings)
		settings = new(src)

	known_inventory = list()
	known_buttons = list()

	if(!savedata)
		savedata = new(src)

	setup_stylesheets()

	if(usr)
		return ..()

	welcome()
	make_lobby(locate(1,1,1))
	play_sound('sounds/music/menu/lobby.ogg',list(src.mob),list(src.mob.x,src.mob.y,src.mob.z),loop=1,channel=SOUND_CHANNEL_MUSIC,volume=12)

	if(!connection_data)
		connection_data = new(src)

	world.update_status()
	broadcast_to_clients("[ckey] has joined the game.")

/client/proc/make_lobby(var/desired_loc)
	src.mob = new /mob/abstract/observer(desired_loc,src)
	src.mob.Initialize()
	winset(src, "map.map","icon-size=[TILE_SIZE*2];zoom-mode=normal")
	//update_lighting()

/client/proc/welcome()
	src << "<title>Welcome to Burgerstation 13</title>"
	src << "This is a work in progress server for testing out currently working features and other memes. Absolutely anything and everything will end up being changed."
	src << "If you wish to join the discord, please do so here: https://discord.gg/yEaV92a"

/client/Del()
	all_clients -= src
	world.update_status()
	..()

/client/Command(command as command_text)
	mob.say(command)
	return TRUE

/client/Topic(href,href_list)

	/*
	if(next_allowed_topic > curtime)
		to_chat(span("danger","You're sending information too fast! Please wait [next_allowed_topic - curtime] second\s!"))
		return FALSE
	*/

	/*
	if(length(href_list) > 32)
		to_chat(span("danger","No."))
		return FALSE

	if(length(href) > 1000)
		to_chat(span("danger","No!"))
		return FALSE
	*/

	if(length(href_list) && href_list["done_loading"])
		send_load(src.mob,href_list["done_loading"])

	..()

	next_allowed_topic = curtime + 1


/client/verb/button_press(button as text)
	set hidden = TRUE
	set instant = TRUE
	if(!disable_controls)
		button_tracker.set_pressed(button)

/client/verb/button_release(button as text)
	set hidden = TRUE
	set instant = TRUE
	if(!disable_controls)
		button_tracker.set_released(button)

/client/proc/make_ghost(var/desired_loc)
	src.mob = new /mob/abstract/observer(desired_loc,src)
	src.mob.Initialize()
	//update_lighting()

/client/MouseWheel(object,delta_x,delta_y,location,control,params)
	var/change_in_screen = delta_y > 1 ? 1 : -1
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

/client/proc/get_click_flags(aug,var/check_swap = FALSE)

	var/returning = 0x0

	if((swap_mouse && check_swap) ? ("left" in aug) :("right" in aug))
		returning |= CLICK_RIGHT

	if((swap_mouse && check_swap) ? ("right" in aug) : ("left" in aug))
		returning |= CLICK_LEFT

	if("middle" in aug)
		returning |= CLICK_MIDDLE

	return returning

/client/MouseDown(var/atom/object,location,control,params)

	store_new_params(object,location,params)

	var/list/aug = params2list(params)
	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.attack_flags |= ATTACK_HELD_LEFT
		mob.on_left_down(object,location,control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.attack_flags |= ATTACK_HELD_RIGHT
		mob.on_right_down(object,location,control,aug)

	if(click_flags & CLICK_MIDDLE)
		examine(object)
		return TRUE


	..()

/client/proc/get_variables(var/datum/object)
   for(var/v in object.vars)
      src << "[v] = [object.vars[v]]"

/client/Click(var/atom/object,location,control,params)

	var/list/aug = params2list(params)
	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_click(object,location,control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_click(object,location,control,aug)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_click(object,location,control,aug)

	..()

/client/MouseUp(object,location,control,params)

	var/list/aug = params2list(params)
	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.attack_flags &= ~ATTACK_HELD_LEFT

	if(click_flags & CLICK_RIGHT)
		mob.attack_flags &= ~ATTACK_HELD_RIGHT


	if(is_advanced(mob))

		var/mob/living/advanced/A = mob
		var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon
		click_and_drag_icon.stored_object = null
		click_and_drag_icon.alpha = 0

	..()

/client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)

	if(src_object == over_object)
		return

	var/list/aug = params2list(params)
	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	..()

/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)
	store_new_params(over_object,over_location,params)

	if(is_advanced(mob) && is_inventory(src_object))
		var/list/params_list = params2list(params)
		var/mob/living/advanced/A = mob
		var/atom/object = src_object
		object = object.defer_click_on_object()
		if(!is_inventory(object))
			var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon

			var/screen_loc = params_list["screen-loc"]

			var/list/screen_loc_list = splittext(screen_loc,",")

			var/x_list = splittext(screen_loc_list[1],":")
			var/y_list = splittext(screen_loc_list[2],":")

			var/x_full = text2num(x_list[1])
			var/x_partial = text2num(x_list[2])

			var/y_full = text2num(y_list[1])
			var/y_partial = text2num(y_list[2])

			x_partial -= 16
			y_partial -= 16

			if(x_partial < 0)
				x_full -= 1
				x_partial += 32

			if(y_partial < 0)
				y_full -= 1
				y_partial += 32

			click_and_drag_icon.screen_loc = "[x_full]:[x_partial],[y_full]:[y_partial]"

			if(click_and_drag_icon.stored_object != object)
				click_and_drag_icon.appearance = object.appearance
				click_and_drag_icon.stored_object = object
				click_and_drag_icon.mouse_opacity = 0
				click_and_drag_icon.alpha = 100


	..()

/client/MouseMove(object,location,control,params)

	if(is_zoomed)

		var/list/params_list = params2list(params)
		var/list/screen_loc = parse_screen_loc(params_list["screen-loc"])

		pixel_x = Clamp( (screen_loc[1] - VIEW_RANGE*TILE_SIZE)*3, -ZOOM_RANGE*TILE_SIZE, ZOOM_RANGE*TILE_SIZE)
		pixel_y = Clamp( (screen_loc[2] - VIEW_RANGE*TILE_SIZE)*3, -ZOOM_RANGE*TILE_SIZE, ZOOM_RANGE*TILE_SIZE)

		if(mob)
			mob.face_atom(location)

	..()

/client/proc/store_new_params(over_object,over_location,params)
	var/list/new_params = params2list(params)
	last_params = new_params
	last_object = over_object
	last_location = over_location

/client/proc/update_zoom(var/desired_zoom_level)
	if(!mob || !eye || eye != mob)
		desired_zoom_level = MIN_ZOOM
	else if(desired_zoom_level < 0)
		desired_zoom_level = initial(zoom_level)

	zoom_level = Clamp(desired_zoom_level,MIN_ZOOM,MAX_ZOOM)

	winset(src, "map.map","icon-size=[zoom_level*TILE_SIZE];zoom-mode=normal")

/client/proc/save_current_character()
	savedata.save_current_character()

/client/proc/get_permissions()
	return FALSE