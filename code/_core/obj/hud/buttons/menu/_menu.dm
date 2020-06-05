/obj/hud/button/menu
	name = "menu button"
	icon_state = "none"
	mouse_opacity = 2

/obj/hud/button/menu/title
	name = "Burgerstation 13"
	maptext = "<font size='4'>Burgerstation 13</font>"
	maptext_width = TILE_SIZE*6
	screen_loc = "LEFT+1,CENTER+1"

/obj/hud/button/menu/selection
	maptext_width = TILE_SIZE*2
	maptext_y = 10
	var/command_to_run

/obj/hud/button/menu/selection/clicked_on_by_object(var/mob/caller,object,location,control,params)

	. = ..()

	if(caller.client && command_to_run)
		winset(caller.client,null,"command=[command_to_run]")

	return .

/obj/hud/button/menu/selection/New(var/desired_loc)
	maptext = name
	return ..()

/obj/hud/button/menu/selection/MouseEntered(location,control,params)
	maptext = "<font color='#FFB200'>[name]</font>"
	return ..()

/obj/hud/button/menu/selection/MouseExited(location,control,params)
	maptext = name
	return ..()

/obj/hud/button/menu/selection/character_new
	name = "New Character"
	screen_loc = "LEFT+1,CENTER"
	command_to_run = "new-character"

/obj/hud/button/menu/selection/character_load
	name = "Load Character"
	screen_loc = "LEFT+1,CENTER-1"
	command_to_run = "load-character"

/obj/hud/button/menu/selection/observe
	name = "Observe"
	screen_loc = "LEFT+1,CENTER-2"
	command_to_run = "observe"

/obj/hud/button/menu/selection/macros
	name = "Macros"
	screen_loc = "LEFT+1,CENTER-3"
	command_to_run = "edit-macros"