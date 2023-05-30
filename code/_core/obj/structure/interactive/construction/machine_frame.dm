/obj/structure/interactive/construction/machine_frame
	name = "machine frame"
	desc = "A metal machine frame."
	desc_extended = "I should add some electronics if its a complex machine, otherwise, I'll just need some other part."
	icon_state = "machine_frame"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE
	anchored = FALSE
	health_base = 100
	var/electronics = FALSE
	bullet_block_chance = 90

/obj/structure/interactive/construction/machine_frame/proc/make_machine(var/mob/caller,var/obj/item/S,var/machine_to_make)
	var/turf/T = src.loc
	new machine_to_make(T)
	S.add_item_count(-1)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/machine_frame/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 1),material_id)
	. = ..()
	qdel(src)

obj/structure/interactive/construction/machine_frame/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the machine frame."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the machine frame."))
				anchored = TRUE
	if(istype(object,/obj/item/container/healing/cable))
		var/obj/item/P = object
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		electronics = TRUE
		P.add_item_count(-1)
		return TRUE
	if(istype(object,/obj/item/weapon/melee/tool/pickaxe) && electronics)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		make_machine(caller,object,/obj/structure/interactive/mining_drill)
		return TRUE
	if(istype(object,/obj/item/material/sheet))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		make_machine(caller,object,/obj/structure/interactive/mining_brace)
		return TRUE
	if(istype(object,/obj/item/crafting_bench/smelter))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		make_machine(caller,object,/obj/structure/interactive/smelter)
		return TRUE
	if(istype(object,/obj/item/material/rod))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		make_machine(caller,object,/obj/structure/interactive/conveyor)
	return ..()
