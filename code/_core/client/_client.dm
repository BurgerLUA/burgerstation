var/global/list/all_clients = list() //Assoc list

#define string2params(str) list2params(list(str))

//Credit to Kaiochao for the button tracker and Anymacro framework
/client/
	var/button_tracker/button_tracker
	var/macros/macros

	//control_freak = CONTROL_FREAK_ALL //Just for now as I don't want people's binds to get messed up
	fps = FPS_CLIENT
	preload_rsc = 1
	view = VIEW_RANGE

	var/list/obj/hud/inventory/known_inventory
	var/list/obj/hud/button/known_buttons
	var/list/obj/hud/button/known_health_elements

	var/zoom_level = 2

	var/savedata/client/connection_history/connection_data
	var/savedata/client/settings/settings
	var/savedata/client/controls/controls
	var/savedata/client/globals/globals

	//var/save_slot //The character slot that the client wishes to overwrite.
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

	var/is_zoomed = 0x0 //Takes a dir as a value.

	var/next_allowed_topic = -1

	var/list/queued_chat_messages = list()

	var/allow_zoom_controls = TRUE //Disabled usually during cutscenes.

	var/ping_num = 0

	var/spam_protection_chat = 0 //Prevents users from spamming every tick.
	var/last_message //See above.

	var/list/stored_hud_images = list() //For MediHUDs

	var/mouse_down_x = 0
	var/mouse_down_y = 0

	var/list/color_mods = list()

	var/examine_mode = FALSE

	var/permissions = FLAG_PERMISSION_NONE

	var/desired_pixel_x = 0
	var/desired_pixel_y = 0

	var/desired_recoil_x = 0
	var/desired_recoil_y = 0

	var/desired_punch_x = 0
	var/desired_punch_y = 0

	var/precise_zoom = FALSE

	var/byond_member = FALSE


/client/proc/is_player_controlled()
	return TRUE //duh

/client/proc/set_permissions(var/desired_permissions = FLAG_PERMISSION_NONE)
	permissions = desired_permissions
	update_verbs()

/client/proc/get_debug_name()
	return "[src](MOB: [mob ? "[mob.name]([mob.x])([mob.y])([mob.z])" : "NONE"])"

/client/Del() //Called when the client disconnects.

	all_clients -= src.ckey

	if(known_inventory)
		known_inventory.Cut()

	if(known_buttons)
		known_buttons.Cut()

	if(known_health_elements)
		known_health_elements.Cut()

	last_location = null
	last_object = null

	QDEL_NULL(connection_data)
	QDEL_NULL(settings)
	QDEL_NULL(macros)
	QDEL_NULL(controls)

	clear_mob(mob)

	world.update_status()

	return ..()


/client/proc/examine(var/atom/object)

	for(var/v in object.get_examine_list(src.mob))
		src.mob.to_chat(v)

	return TRUE

/client/New()

	all_clients[src.ckey] = src

	CLEAR_VERBS(src)

	if(!button_tracker)
		button_tracker = new(src)

	if(!macros)
		macros = new(src)

	if(!controls)
		controls = new(ckey)

	if(!settings)
		settings = new(ckey)

	if(!connection_data)
		connection_data = new(ckey)

	if(!globals)
		globals = new(ckey)

	var/savedata/client/mob/mobdata = MOBDATA(ckey)
	if(!mobdata)
		new/savedata/client/mob(ckey)

	known_health_elements = list()
	known_inventory = list()
	known_buttons = list()

	update_zoom(2)

	if(SSadmin.initialized)
		sync_permissions()

	var/mob/found_mob = null
	for(var/mob/M in all_mobs)
		if(M.ckey_last == ckey)
			found_mob = M
			break

	if(found_mob)
		control_mob(found_mob)
	else
		welcome()
		make_observer(FALLBACK_TURF)
		mob.show_hud(FALSE,speed = 0)
		if(world_state == STATE_RUNNING)
			play_music_track("slow_fall", src)
			mob.show_hud(TRUE,speed = 2)

	world.update_status()
	broadcast_to_clients("<b>[ckey] has joined the game.</b>")
	update_window()
	update_color_mods()

	if(IsByondMember())
		byond_member = TRUE

	return mob

/client/proc/get_ranks()

	var/list/rank/ranks = list(SSadmin.stored_ranks["user"])
	if(src.address == null) ranks |= SSadmin.stored_ranks["host"]
	if(SSadmin.stored_user_ranks[ckey])
		for(var/rank/R in SSadmin.stored_user_ranks[ckey])
			ranks |= R

	return ranks


/client/proc/sync_permissions()

	var/list/rank/ranks = get_ranks()

	for(var/rank/R in ranks)
		to_chat("Adding [R.name] permissions...")
		permissions |= R.permissions

	return TRUE

/client/proc/welcome()
	to_chat("<title>Welcome to Burgerstation 13</title><p>This is a work in progress server for testing out currently working features and other memes. Absolutely anything and everything will end up being changed. If you wish to join the discord, please do so here: https://discord.gg/yEaV92a</p>")
	return TRUE

/*
/client/Command(command as command_text)
	mob.say(command)
	return TRUE
*/

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
	if(!screen_loc)
		return FALSE
	mouse_down_x = screen_loc[1]
	mouse_down_y = screen_loc[2]

	store_new_params(object,location,params)

	var/click_flags = get_click_flags(aug,TRUE)

	if(examine_mode)
		examine(object)
		return ..()

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

	if(is_player(mob))
		var/mob/living/advanced/player/A = mob
		if(A.click_and_drag_icon)
			var/obj/hud/click_and_drag/click_and_drag_icon = A.click_and_drag_icon
			click_and_drag_icon.stored_object = null
			click_and_drag_icon.stored_inventory = null
			click_and_drag_icon.alpha = 0

	return ..()

/client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)

	if(src_object == over_object)
		return FALSE

	var/list/aug = params2list(params)

	var/list/screen_loc = parse_screen_loc(aug["screen-loc"])
	if(!screen_loc)
		return FALSE
	if(abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) < TILE_SIZE*0.5)
		return FALSE

	var/click_flags = get_click_flags(aug,TRUE)

	if(click_flags & CLICK_LEFT)
		mob.on_left_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_RIGHT)
		mob.on_right_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	if(click_flags & CLICK_MIDDLE)
		mob.on_middle_drop(src_object,over_object,src_location,over_location,src_control,over_control,aug)

	return ..()


/client/MouseDrag(src_object,over_object,src_location,over_location,src_control,over_control,params)

	var/list/aug = params2list(params)

	var/list/screen_loc = parse_screen_loc(aug["screen-loc"])
	if(!screen_loc)
		return FALSE
	if(abs(mouse_down_x - screen_loc[1]) + abs(mouse_down_y - screen_loc[2]) <= 8) //Only store the new params if the movement has changed more than 8 units.
		return FALSE

	store_new_params(over_object,over_location,params)

	..()


/client/proc/store_new_params(over_object,over_location,params)
	var/list/new_params = params2list(params)
	last_params = new_params
	last_object = over_object
	last_location = over_location

/client/proc/receive_sound(var/sound/S)
	src << S