/obj/structure/interactive/construction/machine_frame
	name = "machine frame"
	desc = "A metal machine frame."
	icon_state = "machine_frame"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	health_base = 100
	var/electronics = FALSE
	bullet_block_chance = 90

/obj/structure/interactive/construction/machine_frame/proc/can_construct_reinf_wall(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/turf/simulated/wall/))
		caller.to_chat(span("warning","There is already a machine frame here... somehow."))
		return FALSE
	if(S.amount < 1)
		caller.to_chat(span("warning","You need a sheet in order to build a machine frame!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE
/obj/structure/interactive/construction/machine_frame/proc/make_machine(var/mob/caller,var/obj/item/S,var/machine_to_make)
	var/turf/T = src.loc
	new machine_to_make(T)
	S.add_item_count(-1)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/machine_frame/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 2),material_id)
	. = ..()
	qdel(src)

obj/structure/interactive/construction/machine_frame/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/crafting/ingredient/part/electronics))
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
	if(istype(object,/obj/item/material/rod/steel))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("notice","[caller.name] inserts some parts into the [src.name]."),span("notice","You insert some parts into the [src.name]."))
		make_machine(caller,object,/obj/structure/interactive/mining_brace)
		return TRUE
	return ..()