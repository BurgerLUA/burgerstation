/obj/hud/button/menu
	name = "menu button"
	icon = 'icons/hud/menu.dmi'
	mouse_opacity = 1

	flags = FLAGS_HUD_MOB

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/menu/title
	name = "Burgerstation 13"
	icon_state = "title"
	screen_loc = "LEFT+1,CENTER+2"

/obj/hud/button/menu/selection
	var/command_to_run

/obj/hud/button/menu/selection/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && caller.client && command_to_run)
		winset(caller.client,null,"command=[command_to_run]")

	return .

/obj/hud/button/menu/selection/New(var/desired_loc)
	color = null
	return ..()

/obj/hud/button/menu/selection/MouseEntered(location,control,params)
	color = "#FFB200"
	return ..()

/obj/hud/button/menu/selection/MouseExited(location,control,params)
	color = null
	return ..()

/obj/hud/button/menu/selection/character_new
	name = "Join as New Character"
	icon_state = "new"
	screen_loc = "LEFT+1,CENTER+1"
	command_to_run = "new-character"

/obj/hud/button/menu/selection/character_load
	name = "Join as Existing Character"
	icon_state = "load"
	screen_loc = "LEFT+1,CENTER-0"
	command_to_run = "load-character"

/obj/hud/button/menu/selection/join_antagonist
	name = "Join as Antagonist"
	icon_state = "antag"
	screen_loc = "LEFT+1,CENTER-1"
	command_to_run = "become-antagonist"

/obj/hud/button/menu/selection/observe
	name = "Observe"
	icon_state = "observe"
	screen_loc = "LEFT+1,CENTER-2"
	command_to_run = "observe"


/obj/hud/button/menu/selection/macros
	name = "Macros"
	icon_state = "macros"
	screen_loc = "LEFT+1,CENTER-3"
	command_to_run = "edit-macros"