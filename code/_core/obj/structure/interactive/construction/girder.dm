/obj/structure/interactive/construction/girder
	name = "girder"
	desc = "A metal girder."
	desc_extended = "Could probably add some plates for a wall, or a couple rods for a door."
	icon_state = "girder"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	density = TRUE

	health_base = 100

	bullet_block_chance = 90


/obj/structure/interactive/construction/girder/proc/can_construct_wall(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/turf/simulated/wall/))
		caller.to_chat(span("warning","There is already a wall here... somehow."))
		return FALSE
	if(S.amount < 1)
		caller.to_chat(span("warning","You need a sheet in order to build a wall!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE
/obj/structure/interactive/construction/girder/proc/can_construct_door(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/turf/simulated/wall/))
		caller.to_chat(span("warning","There is already a wall here... somehow."))
		return FALSE
	if(S.amount < 2)
		caller.to_chat(span("warning","You need 2 rods in order to build a door!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE
/obj/structure/interactive/construction/girder/proc/construct_door(var/mob/caller,var/obj/item/material/sheet/S)
	var/obj/structure/interactive/door/airlock/glass/W = new(src.loc)
	//W.material_id = S.material_id NYI
	//W.color = S.color NYI
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)
	caller?.visible_message(span("notice","\The [caller.name] places \the [W.name]."),span("notice","You place \the [W.name]."))
	S.add_item_count(-2)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/girder/proc/construct_wall(var/mob/caller,var/obj/item/material/sheet/S)
	var/turf/simulated/T = src.loc
	T.change_turf(/turf/simulated/wall/metal/)
	T.material_id = material_id
	T.color = color
	caller?.visible_message(span("notice","\The [caller.name] places \the [T.name]."),span("notice","You place \the [T.name]."))
	S.add_item_count(-1)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/girder/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 1),material_id)
	. = ..()
	qdel(src)


/obj/structure/interactive/construction/girder/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/material/sheet/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),src::construct_wall(),caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_construct_wall(),caller,object)
		return TRUE
	if(istype(object,/obj/item/material/rod/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),src::construct_door(),caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,src::can_construct_door(),caller,object)
		return TRUE
	if(istype(object,/obj/item))
		var/obj/item/T = object
		if(T.flags_tool & FLAG_TOOL_WRENCH)
			if(anchored)
				caller.to_chat(span("notice","You un-anchor the girder."))
				anchored = FALSE
			else
				caller.to_chat(span("notice","You anchor the girder."))
				anchored = TRUE
		if(T.flags_tool & FLAG_TOOL_WIRECUTTER)
			caller.to_chat(span("notice","You dissasemble the [src.name]"))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			if(src.can_do_destruction(FALSE))
				src.on_destruction(FALSE)
			return TRUE
		return TRUE
	return ..()
