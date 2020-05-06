var/global/list/obj/hud/button/objectives/all_objective_buttons = list()

/obj/hud/button/objectives
	name = "objectives"
	screen_loc = "LEFT,BOTTOM+4"
	maptext_width = TILE_SIZE*VIEW_RANGE
	maptext_height = TILE_SIZE*VIEW_RANGE
	maptext = ""
	icon_state = "none"
	mouse_opacity = 2
	var/stored_text = "Objectives:<br>None"

/obj/hud/button/objectives/proc/set_stored_text(var/desired_text)
	stored_text = desired_text + "<br>"
	if(maptext)
		maptext = stored_text

/obj/hud/button/objectives/New(var/desired_loc)
	all_objective_buttons += src

	if(SShorde && SShorde.last_update)
		stored_text = SShorde.last_update
		maptext = stored_text
		if(!maptext)
			icon_state = "close_objectives"
	else
		icon_state = "close_objectives"

	return ..()

/obj/hud/button/objectives/Destroy()
	all_objective_buttons -= src
	return ..()


/obj/hud/button/objectives/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!maptext)
		maptext = stored_text
		icon_state = "none"
	else
		maptext = ""
		icon_state = "close_objectives"

	update_sprite()

	return ..()