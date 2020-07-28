var/global/list/obj/hud/button/objectives/all_objective_buttons = list()

/obj/hud/button/objectives
	name = "objectives"
	screen_loc = "LEFT,BOTTOM+4"
	maptext_width = TILE_SIZE*VIEW_RANGE
	maptext_height = TILE_SIZE*VIEW_RANGE
	alpha = 100
	maptext = null
	maptext_x = 16
	icon = 'icons/hud/objectives.dmi'
	icon_state = "objectives"
	mouse_opacity = 2
	var/stored_text = "Objectives:<br>None"

/obj/hud/button/objectives/proc/set_stored_text(var/desired_text)

	stored_text = desired_text + "<br>"
	if(maptext)
		maptext = stored_text
		animate(src,alpha = 255,time = 1)

/obj/hud/button/objectives/New(var/desired_loc)
	all_objective_buttons += src
	return ..()

/obj/hud/button/objectives/update_owner(var/mob/desired_owner)

	. = ..()

	if(. && SSgamemode && SSgamemode.active_gamemode && SSgamemode.active_gamemode.objective_text)
		set_stored_text(SSgamemode.active_gamemode.objective_text)

	return .

/obj/hud/button/objectives/Destroy()
	all_objective_buttons -= src
	return ..()

/obj/hud/button/objectives/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(.)
		if(!maptext)
			alpha = 100
			maptext = stored_text
			animate(src,alpha = 255,time = 1)
		else
			alpha = 255
			maptext = null
			animate(src,alpha = 100,time = 1)

	return .