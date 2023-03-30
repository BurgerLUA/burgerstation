/obj/hud/button/crafting/
	name = "yeah"

	essential = TRUE

	flags_hud = FLAG_HUD_MOB | FLAG_HUD_SPECIAL

	var/obj/item/crafting_bench/stored_crafting_table

	has_quick_function = FALSE

	layer = 0

/obj/hud/button/crafting/Destroy()
	stored_crafting_table = null
	return ..()

/obj/hud/button/crafting/craft
	name = "craft object"
	icon_state = "arrow"
	dir = EAST
	screen_loc = "CENTER+2,TOP-3"

/obj/hud/button/crafting/craft/New(var/desired_loc)
	. = ..()
	mouse_opacity = 0
	alpha = 0

/obj/hud/button/crafting/craft/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		if(stored_crafting_table)
			stored_crafting_table.attempt_to_craft(caller)
		else
			log_error("Warning: [caller.get_debug_name()] tried to craft without a stored crafting table!")



/obj/hud/button/crafting/close
	name = "close crafting menu"
	icon_state = "close_crafting"
	screen_loc = "CENTER-2,TOP-3"

/obj/hud/button/crafting/close/New(var/desired_loc)
	. = ..()
	mouse_opacity = 0
	alpha = 0

/obj/hud/button/crafting/close/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		stored_crafting_table.toggle_crafting(caller)
