/obj/structure/interactive/construction/girder
	name = "girder"
	desc = "A metal girder."
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
	if(S.item_count_current < 4)
		caller.to_chat(span("warning","You need 4 sheets in order to build a wall!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/girder/proc/construct_wall(var/mob/caller,var/obj/item/material/sheet/S)
	var/turf/T = src.loc
	T.change_turf(/turf/simulated/wall/metal/)
	T.material_id = material_id
	T.color = color
	caller?.visible_message(span("notice","\The [caller.name] places \the [T.name]."),span("notice","You place \the [T.name]."))
	S.add_item_count(-4)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/girder/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 2),material_id)
	. = ..()
	qdel(src)
	return .


obj/structure/interactive/construction/girder/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(istype(object,/obj/item/material/sheet/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_wall,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_wall,caller,object)
		return TRUE

	return ..()