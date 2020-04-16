var/global/list/all_clients = list()

#define string2params(str) list2params(list(str))

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/button_tracker/button_tracker
	var/macros/macros

	//control_freak = CONTROL_FREAK_ALL //Just for now as I don't want people's binds to get messed up
	fps = FPS_CLIENT
	preload_rsc = 1

	var/list/obj/hud/inventory/known_inventory
	var/list/obj/hud/button/known_buttons
	var/list/obj/hud/button/known_health_elements

	var/zoom_level = MIN_ZOOM

	var/savedata/client/connection_history/connection_data
	var/savedata/client/roles/roles
	var/savedata/client/settings/settings

	var/save_slot //The character slot that the client wishes to overwrite.
	var/list/last_params
	var/atom/last_object
	var/atom/last_location

	mouse_pointer_icon = 'icons/pointer.dmi'

	var/swap_mouse = FALSE

	perspective = EYE_PERSPECTIVE

	var/current_music_track //Id of music track that last played.
	var/next_music_track = 0 //When the next music track should be triggered.

	var/current_ambient_sound

	var/disable_controls = FALSE

	var/is_zoomed = FALSE

	var/next_allowed_topic = -1

	var/update_stats = FALSE

	var/list/queued_chat_messages = list()

	var/last_ooc = 0
	var/inactivity_warning_stage = 0

	var/allow_zoom_controls = TRUE

	var/ping_num = 0

	var/spam_protection_chat = 0 //Prevents users from spamming every tick.

	var/list/stored_hud_images = list() //For MediHUDs

	var/mouse_down_x = 0
	var/mouse_down_y = 0

//Ping verb based on Ter13 http://www.byond.com/forum/post/99653?page=2#comment21759302

/*
/client/verb/ping()
	winset(src,null,"command=pong+[world.time]")

/client/verb/pong(var/time as num)
	ping_num = world.time - time
*/

/client/Del() //Called when the client disconnects.

	if(known_inventory)
		known_inventory.Cut()

	if(known_buttons)
		known_buttons.Cut()

	if(known_health_elements)
		known_health_elements.Cut()

	last_location = null
	last_object = null

	qdel(connection_data)
	connection_data = null

	qdel(settings)
	settings = null

	qdel(macros)
	macros = null

	clear_mob(mob)

	all_clients -= src
	world.update_status()

	return ..()

/client/proc/setup_stylesheets()
	winset(src,"chat_all.output","style='[STYLESHEET]'")
	winset(src,"chat_combat.output","style='[STYLESHEET]'")
	winset(src,"chat_looc.output","style='[STYLESHEET]'")
	winset(src,"chat_ooc.output","style='[STYLESHEET]'")
	winset(src,"chat_say.output","style='[STYLESHEET]'")

/client/proc/examine(var/atom/object)

	for(var/v in object.get_examine_list(src.mob))
		src.mob.to_chat(v)

	return TRUE

/client/New()

	all_clients += src

	if(!button_tracker)
		button_tracker = new(src)

	if(!macros) //TODO: LOADING SYSTEM OF CUSTOM MACROS
		macros = new(src)

	if(!settings)
		settings = new(src)

	known_health_elements = list()
	known_inventory = list()
	known_buttons = list()

	setup_stylesheets()

	update_zoom(-1)

	var/mob/found_mob = null
	for(var/mob/M in all_mobs)
		if(M.ckey_last == ckey)
			found_mob = M
			break

	if(found_mob)
		control_mob(found_mob)
	else
		welcome()
		make_ghost(FALLBACK_TURF)
		if(world_state == STATE_RUNNING)
			play_music_track("intro", src)
		else
			play_music_track("loading", src)

	if(!connection_data)
		connection_data = new(src)
	world.update_status()
	broadcast_to_clients("<b>[ckey] has joined the game.</b>")
	update_window()

	return mob

/client/proc/welcome()
	to_chat("<title>Welcome to Burgerstation 13</title><p>This is a work in progress server for testing out currently working features and other memes. Absolutely anything and everything will end up being changed. If you wish to join the discord, please do so here: https://discord.gg/yEaV92a</p>")
	return TRUE

/*
/client/Command(command as command_text)
	mob.say(command)
	return TRUE
*/

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

/client/verb/change_click_mode()
	set name = "Swap Click Mode"
	set category = "Preferences"
	swap_mouse = !swap_mouse
	if(swap_mouse)
		to_chat(span("ui notice","Right clicking will now activate the object in your right hand, and vice versa."))
	else
		to_chat(span("ui notice","Left clicking will now activate the object in your right hand, and vice versa."))

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

	var/list/aug = params2list(params)

	var/list/screen_loc = parse_screen_loc(aug["screen-loc"])
	mouse_down_x = screen_loc[1]
	mouse_down_y = screen_loc[2]

	store_new_params(object,location,params)

	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.attack_flags |= ATTACK_HELD_LEFT
		return mob.on_left_down(object,location,control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.attack_flags |= ATTACK_HELD_RIGHT
		return mob.on_right_down(object,location,control,aug)

	if(click_flags & CLICK_MIDDLE)
		examine(object)
		return TRUE

	..()

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

/client/proc/get_variables(var/datum/object)
   for(var/v in object.vars)
      src << "[v] = [object.vars[v]]"

/client/MouseUp(object,location,control,params)

	var/list/aug = params2list(params)
	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_up(object,location,control,aug)
		mob.attack_flags &= ~ATTACK_HELD_LEFT

	if(click_flags & CLICK_RIGHT)
		mob.on_right_up(object,location,control,aug)
		mob.attack_flags &= ~ATTACK_HELD_RIGHT

	if(is_advanced(mob))
		var/mob/living/advanced/A = mob
		if(A.click_and_drag_icon)
			var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon
			click_and_drag_icon.stored_object = null
			click_and_drag_icon.alpha = 0

	..()

/client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)

	if(src_object == over_object)
		return

	var/list/aug = params2list(params)

	var/list/screen_loc = parse_screen_loc(aug["screen-loc"])
	if(abs(mouse_down_x-screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.5)
		return FALSE

	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	..()

/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)

	var/list/aug = params2list(params)


	var/list/screen_loc = parse_screen_loc(aug["screen-loc"])
	if(abs(mouse_down_x-screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.5)
		return FALSE

	store_new_params(over_object,over_location,params)

	if(is_advanced(mob) && is_inventory(src_object))
		var/list/params_list = params2list(params)
		var/mob/living/advanced/A = mob
		var/atom/object = src_object
		object = object.defer_click_on_object()
		if(!is_inventory(object))
			var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon

			var/list/screen_loc_list = splittext(params_list["screen-loc"],",")

			if(!length(screen_loc_list))
				return ..()

			var/x_list = splittext(screen_loc_list[1],":")
			var/y_list = splittext(screen_loc_list[2],":")

			var/x_full = text2num(x_list[1])
			var/x_partial = text2num(x_list[2])

			var/y_full = text2num(y_list[1])
			var/y_partial = text2num(y_list[2])

			x_full = max(1,x_full)
			y_full = max(1,y_full)

			x_partial -= TILE_SIZE*0.5
			y_partial -= TILE_SIZE*0.5

			if(x_partial < 0 && x_full > 1)
				x_full -= 1
				x_partial += TILE_SIZE-1

			if(y_partial < 0 && y_full > 1)
				y_full -= 1
				y_partial += TILE_SIZE-1

			click_and_drag_icon.screen_loc = "[x_full]:[x_partial],[y_full]:[y_partial]"

			if(click_and_drag_icon.stored_object != object)
				click_and_drag_icon.appearance = object.appearance
				click_and_drag_icon.stored_object = object
				click_and_drag_icon.mouse_opacity = 0
				click_and_drag_icon.alpha = 100


	..()

/client/proc/store_new_params(over_object,over_location,params)
	var/list/new_params = params2list(params)
	last_params = new_params
	last_object = over_object
	last_location = over_location

/client/proc/save_current_character()
	if(mob && is_player(mob))
		var/mob/living/advanced/player/P = mob
		P.mobdata.save_current_character()

/client/proc/get_permissions()
	return FALSE


/client/verb/make_announcement()

	set category = "Fun"
	set name = "Make Announcement"

	if(lowertext(ckey) != "burgerbb")
		src << "You're not an admin!"
		return FALSE

	var/sender = input("Who should the sender be?","Message Sender") as text | null
	if(!sender)
		return FALSE

	var/message = input("What should the message be?", "Message") as message | null
	if(!message)
		return FALSE

	var/header = input("What should the header be?", "Message Header") as text | null
	if(!header)
		return FALSE

	announce(sender,header,message,ANNOUNCEMENT_STATION,'sounds/effects/station/new_command_report.ogg')

	return TRUE