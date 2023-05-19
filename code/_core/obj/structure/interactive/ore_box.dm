/obj/structure/interactive/ore_box
	name = "ore box"
	desc = "A crate for moving and storing ores"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	density = TRUE

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/material/ore))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/material/ore/O = object
		O.drop_item(src)
		return TRUE
	else if(is_advanced(caller))
		var/mob/living/advanced/C = caller
		if(C.selected_intent == INTENT_DISARM)
			for(var/obj/item/material/ore/ore in contents)
				ore.drop_item(get_turf(C))
		C.to_chat(span("notice","You dump all the ores at your feet."))
	return ..()
/obj/structure/interactive/ore_box/Cross(atom/movable/O,atom/oldloc)

	if(istype(O,/obj/item/material/ore/))
		stack(O)
		return FALSE

	return ..()

/obj/structure/interactive/ore_box/proc/stack(var/obj/item/material/ore/O)
	O.drop_item(src)
	for(var/obj/item/material/ore/C in contents)
		if(!O || O.qdeleting)
			break
		if(!C || C.qdeleting)
			continue
		if(O == C)
			continue
		if(!O.can_transfer_stacks_to(C))
			continue
		O.transfer_amount_to(C)
		if(O.qdeleting)
			break
		CHECK_TICK_SAFE(50,FPS_SERVER)

/obj/structure/interactive/ore_box/get_examine_list(var/mob/examiner)

	. = ..()

	. += div("notice","The counter shows [length(contents)] objects inside.")

