/obj/item/ghost_box
	name = "ghost box"
	desc = "No infringement intended."
	desc_extended = "A specialized box that traps hunting ghosts that \"walk\" over them, when active."

	icon = 'icons/obj/item/ghost_trap.dmi'

	var/active = FALSE

	var/stored_ghost = FALSE

	value = 800

	density = TRUE

/obj/item/ghost_box/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("stored_ghost")

/obj/item/ghost_box/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("stored_ghost")

/obj/item/ghost_box/Finalize()
	update_sprite()
	return ..()

/obj/item/ghost_box/get_base_value()
	. = ..()
	if(stored_ghost)
		. += 10000


/obj/item/ghost_box/Crossed(atom/movable/O,atom/OldLoc)

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


/obj/item/ghost_box/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(stored_ghost)
		caller.to_chat(span("warning","\The [src.name] is locked!"))
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


