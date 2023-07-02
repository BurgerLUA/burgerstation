/obj/structure/interactive/construction/reinf_girder
	name = "reinforced girder"
	desc = "A metal reinforced girder."
	desc_extended = "Could probably add some sheets for a reinforced wall."
	icon_state = "girder_reinf"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	health_base = 100

	bullet_block_chance = 90

/obj/structure/interactive/construction/reinf_girder/proc/can_construct_reinf_wall(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/turf/simulated/wall/))
		caller.to_chat(span("warning","There is already a wall here... somehow."))
		return FALSE
	if(S.amount < 1)
		caller.to_chat(span("warning","You need a sheet in order to build a reinforced wall!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/reinf_girder/proc/construct_reinf_wall(var/mob/caller,var/obj/item/material/sheet/S)
	var/turf/T = src.loc
	T.change_turf(/turf/simulated/wall/metal/reinforced)
	caller?.visible_message(span("notice","\The [caller.name] places \the [T.name]."),span("notice","You place \the [T.name]."))
	S.add_item_count(-1)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/reinf_girder/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 2),material_id)
	. = ..()
	qdel(src)


obj/structure/interactive/construction/reinf_girder/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the reinforced girder."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the reinforced girder."))
				anchored = TRUE
		if(T.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			if(src.can_do_destruction(FALSE))
				caller.to_chat(span("notice","You dissasemble the [src.name]"))
				src.on_destruction(FALSE)
			return TRUE
	if(istype(object,/obj/item/material/sheet/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),src::construct_reinf_wall(),caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_construct_reinf_wall(),caller,object)
		return TRUE
	return ..()
