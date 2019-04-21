/obj/button/new_character/
	name = "create a new character"
	desc = ""
	icon_state = "new_character"
	screen_loc = "CENTER-0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

/obj/button/new_character/clicked_by_object(var/mob/caller,object,location,control,params)
	if(!is_observer(caller))
		caller << "You are not an observer! Please yell at Burger and tell them to fix this."
		return TRUE
	if(world_state != STATE_RUNNING)
		caller << "The game has not loaded yet!"
		return TRUE

	var/mob/abstract/observer/O = caller
	O.new_character()

	return TRUE

/obj/button/load_character/
	name = "load an existing character"
	desc = ""
	icon_state = "load_character"
	screen_loc = "CENTER+0.5,BOTTOM"

	flags = FLAGS_HUD_MOB

/obj/button/load_character/clicked_by_object(var/mob/caller,object,location,control,params)
	if(!is_observer(caller))
		caller << "You are not an observer! Please yell at Burger and tell them to fix this."
		return TRUE
	if(world_state != STATE_RUNNING)
		caller << "The game has not loaded yet!"
		return TRUE

	var/mob/abstract/observer/O = caller
	O.load_character()

	return TRUE