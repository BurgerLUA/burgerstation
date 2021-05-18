/obj/structure/interactive/construction/lattice
	name = "lattice"
	desc = "A metal lattice."
	icon_state = "lattice"

	health_base = 50

/obj/structure/interactive/construction/lattice/proc/can_construct_grille(var/mob/caller,var/obj/item/material/rod/R)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(R)

	if(R.item_count_current < 2)
		caller.to_chat(span("warning","You need 4 rods in order to build a grille!"))
		return FALSE
	if(R.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/lattice/proc/construct_grille(var/mob/caller,var/obj/item/material/rod/R)
	var/obj/structure/interactive/construction/grille/G = new(src.loc)
	G.material_id = R.material_id
	G.color = R.color
	INITIALIZE(G)
	GENERATE(G)
	FINALIZE(G)
	caller?.visible_message(span("notice","\The [caller.name] places \the [G.name]."),span("notice","You place \the [G.name]."))
	R.add_item_count(-4)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/lattice/proc/construct_floor_plating(var/mob/caller,var/obj/item/material/sheet/S)
	var/turf/T = src.loc
	T.change_turf(/turf/simulated/floor/plating/,TRUE)
	T.color = S.color
	T.material_id = S.material_id
	caller?.visible_message(span("notice","\The [caller.name] places \the [T.name]."),span("notice","You place \the [T.name]."))
	S.add_item_count(-4)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/lattice/proc/can_construct_floor_plating(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/turf/simulated/floor/plating/))
		caller.to_chat(span("warning","There is already a floor plating here!"))
		return FALSE
	if(S.item_count_current < 4)
		caller.to_chat(span("warning","You need 4 sheets in order to build a floor plating!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/lattice/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			src.on_destruction(caller)
			return TRUE
		if(istype(I,/obj/item/material/rod/))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_grille,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_grille,caller,object)
			return TRUE
		if(istype(I,/obj/item/material/sheet/))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_floor_plating,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_floor_plating,caller,object)
			return TRUE

	return ..()