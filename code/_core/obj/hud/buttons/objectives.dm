var/global/list/obj/hud/button/objectives/all_objective_buttons = list()

/obj/hud/button/objectives
	name = "objectives"
	screen_loc = "RIGHT,BOTTOM+4"
	maptext_width = TILE_SIZE*VIEW_RANGE
	maptext_height = TILE_SIZE*VIEW_RANGE
	alpha = 100
	maptext = null
	maptext_x = 16
	icon = 'icons/hud/objectives.dmi'
	icon_state = "objectives"
	mouse_opacity = 2

/obj/hud/button/objectives/New(var/desired_loc)
	all_objective_buttons += src
	return ..()

/obj/hud/button/objectives/PreDestroy()
	all_objective_buttons -= src
	return ..()

/obj/hud/button/objectives/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	. = ..()
	caller.to_chat(SSgamemode.active_gamemode.objective_text)

