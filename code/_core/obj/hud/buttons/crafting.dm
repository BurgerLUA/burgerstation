/obj/hud/button/crafting/
	name = "yeah"

	alpha = 0
	mouse_opacity = 0

	essential = TRUE

	flags = FLAGS_HUD_MOB | FLAGS_HUD_SPECIAL

	var/obj/item/crafting/stored_crafting_table

/obj/hud/button/crafting/craft
	name = "craft object"
	icon_state = "arrow"
	dir = EAST
	screen_loc = "CENTER-2,CENTER"


/obj/hud/button/crafting/craft/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller
	world.log << "Table: [stored_crafting_table]"
	attempt_to_craft(A,stored_crafting_table)

	return TRUE

/obj/hud/button/crafting/close
	name = "close crafting menu"
	icon_state = "close_crafting"
	screen_loc = "CENTER-6,CENTER"

/obj/hud/button/crafting/close/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	for(var/obj/hud/inventory/crafting/I in A.inventory)
		animate(I,alpha=0,time=4)
		I.mouse_opacity = 0

	for(var/obj/hud/button/crafting/B in A.buttons)
		animate(B,alpha=0,time=4)
		B.mouse_opacity = 0


	return TRUE