/obj/structure/interactive/construction/lattice
	name = "lattice"
	desc = "A metal lattice."
	icon_state = "lattice"

	health_base = 50

/obj/structure/interactive/construction/lattice/proc/can_construct_grille(var/mob/caller,var/obj/item/material/rod/R)
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
	caller.to_chat(span("notice","You place \the [G.name]."))
	R.add_item_count(-4)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/lattice/proc/construct_floor_plating(var/mob/caller,var/obj/item/material/sheet/S)
	var/turf/T = src.loc
	T.change_turf(/turf/simulated/floor/plating/,TRUE)
	T.color = S.color
	T.material_id = S.material_id
	caller.to_chat(span("notice","You place \the plating."))
	S.add_item_count(-4)
	qdel(src)
	return TRUE

/obj/structure/interactive/construction/lattice/proc/can_construct_floor_plating(var/mob/caller,var/obj/item/material/sheet/S)
	if(istype(src.loc,/turf/simulated/floor/plating/))
		caller.to_chat("There is already a floor plating here!")
		return FALSE
	if(S.item_count_current < 4)
		caller.to_chat(span("warning","You need 4 sheets in order to build a floor plating!"))
		return FALSE
	if(S.material_id != material_id)
		caller.to_chat(span("warning","You don't have the correct material for this!"))
		return FALSE
	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/lattice/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/atom/A = object.defer_click_on_object(location,control,params)

	if(is_item(A))
		var/obj/item/I = A
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			src.on_destruction(caller)
			return TRUE
		if(istype(A,/obj/item/material/rod/))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_grille,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_grille,caller,object)
			return TRUE
		if(istype(A,/obj/item/material/sheet/))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_floor_plating,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_floor_plating,caller,object)
			return TRUE

	return ..()