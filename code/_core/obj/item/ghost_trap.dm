/obj/item/ghost_box
	name = "ghost box"
	desc = "No infringement intended."
	desc_extended = "A specialized box that traps hunting ghosts that \"walk\" over them, when active."

	icon = 'icons/obj/item/ghost_trap.dmi'

	var/active = FALSE

	var/stored_ghost = FALSE

	value = 800

	density = TRUE

/obj/item/ghost_box/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("stored_ghost")
	return .

/obj/item/ghost_box/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("stored_ghost")
	return .

/obj/item/ghost_box/Finalize()
	update_sprite()
	return ..()

/obj/item/ghost_box/get_value()

	. = ..()

	if(stored_ghost)
		. += 10000

	return .

/obj/item/ghost_box/Crossed(atom/movable/O)

	if(stored_ghost)
		return ..()

	. = ..()

	if(istype(O,/mob/living/simple/ghost))
		var/mob/living/simple/ghost/G = O
		if(istype(G.ai,/ai/ghost))
			var/ai/ghost/GAI = G.ai
			if(GAI.objective_attack)
				stored_ghost = TRUE
				update_sprite()
				qdel(G)

	return .

/obj/item/ghost_box/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(stored_ghost)
		caller.to_chat(span("warning","\The [src.name] is locked!."))
	else if(active)
		caller.to_chat(span("notice","You turn off \the [src.name]."))
		active = FALSE
	else
		caller.to_chat(span("notice","You turn on \the [src.name]."))
		active = TRUE

	update_sprite()

	return TRUE

/obj/item/ghost_box/update_icon()

	icon_state = initial(icon_state)

	if(stored_ghost)
		icon_state = "[icon_state]_filled"
	else if(active)
		icon_state = "[icon_state]_on"

	return ..()


