/obj/hud/button/menu
	name = "menu button"
	icon = 'icons/hud/menu.dmi'
	mouse_opacity = 1

	flags_hud = FLAG_HUD_MOB

/obj/hud/button/menu/title
	name = "Halo: Winter Contingency"
	icon_state = "title"
	screen_loc = "LEFT+1,CENTER+2"

/obj/hud/button/menu/selection
	var/command_to_run

/obj/hud/button/menu/selection/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && caller.client && command_to_run)
		winset(caller.client,null,"command=[command_to_run]")


/obj/hud/button/menu/selection/New(var/desired_loc)
	color = null
	return ..()

/obj/hud/button/menu/selection/MouseEntered(location,control,params)
	color = "#FFB200"
	return ..()

/obj/hud/button/menu/selection/MouseExited(location,control,params)
	color = null
	return ..()

/obj/hud/button/menu/selection/join_unsc
	name = "Join as UNSC"
	icon_state = "new"
	screen_loc = "LEFT+1,CENTER+1"
	command_to_run = "become-unsc"

/obj/hud/button/menu/selection/join_urf
	name = "Join as Insurrection"
	icon_state = "antag"
	screen_loc = "LEFT+1,CENTER-0"
	command_to_run = "become-insurrection"

/obj/hud/button/menu/selection/join_covenant
	name = "Join as Covenant"
	icon_state = "cov"
	screen_loc = "LEFT+1,CENTER-1"
	command_to_run = "become-covenant"

/obj/hud/button/menu/selection/observe
	name = "Observe"
	desc_extended = "Click here to observe the current round as a ghost. You can still rejoin the round as a living character after observing."
	icon_state = "observe"
	screen_loc = "LEFT+1,CENTER-2"
	command_to_run = "observe"


/obj/hud/button/menu/selection/macros
	name = "Macros"
	desc_extended = "Click here to edit your current controls and macros. These controls will be exclusive to this server."
	icon_state = "macros"
	screen_loc = "LEFT+1,CENTER-3"
	command_to_run = "edit-macros"