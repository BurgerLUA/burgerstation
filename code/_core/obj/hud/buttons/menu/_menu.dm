/obj/hud/button/menu
	name = "menu button"
	icon = 'icons/hud/menu.dmi'
	mouse_opacity = 1

	flags_hud = FLAG_HUD_MOB

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_DEAD | FLAG_INTERACTION_NO_DISTANCE

/obj/hud/button/menu/title
	name = "Halo: Winter Contingency"
	icon_state = "title"
	screen_loc = "LEFT+1,CENTER+2"

var/global/list/join_buttons = list()

/obj/hud/button/menu/selection
	var/command_to_run

/obj/hud/button/menu/selection/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && caller.client && command_to_run)
		winset(caller.client,null,"command=[command_to_run]")

	return .

/obj/hud/button/menu/selection/New(var/desired_loc)
	var/static/list/bigchungus = list("become-unsc" = TEAM_UNSC, "become-insurrection" = TEAM_URF, "become-covenant" = TEAM_COVENANT)
	var/chungus = command_to_run ? bigchungus[command_to_run] : null
	var/gamemode/chungusmode = SSgamemode.active_gamemode
	if(chungus && chungusmode && isnull(chungusmode.team_points[chungus]))
		qdel(src)
		return
	else if(command_to_run)
		if(!join_buttons[command_to_run])
			join_buttons[command_to_run] = list()
		join_buttons[command_to_run] += src
	color = null
	return ..()

/obj/hud/button/menu/selection/Destroy()
	. = ..()
	if(command_to_run && join_buttons[command_to_run])
		join_buttons[command_to_run] -= src
		if(!length(join_buttons[command_to_run]))
			join_buttons[command_to_run] = null

/obj/hud/button/menu/selection/MouseEntered(location,control,params)
	color = "#FFB200"
	return ..()

/obj/hud/button/menu/selection/MouseExited(location,control,params)
	color = null
	return ..()

/obj/hud/button/menu/selection/character_new
	name = "Join as UNSC"
	icon_state = "new"
	screen_loc = "LEFT+1,CENTER+1"
	command_to_run = "become-unsc"

/obj/hud/button/menu/selection/join_antagonist
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
	icon_state = "observe"
	screen_loc = "LEFT+1,CENTER-2"
	command_to_run = "observe"


/obj/hud/button/menu/selection/macros
	name = "Macros"
	icon_state = "macros"
	screen_loc = "LEFT+1,CENTER-3"
	command_to_run = "edit-macros"