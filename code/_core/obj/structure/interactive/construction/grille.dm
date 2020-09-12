/obj/structure/interactive/construction/grille
	name = "grille"
	desc = "A metal grille."
	icon_state = "grille"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	health_base = 75

	plane = PLANE_WALL

	bullet_block_chance = 50

/obj/structure/interactive/construction/grille/proc/can_construct_window(var/mob/caller,var/obj/item/material/sheet/S)
	if(istype(src.loc,/obj/structure/smooth/window/))
		caller.to_chat("There is already a window here... somehow.")
		return FALSE
	if(S.item_count_current < 4)
		caller.to_chat(span("warning","You need 4 glass sheets in order to build a wall!"))
		return FALSE
	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/grille/proc/construct_window(var/mob/caller,var/obj/item/material/sheet/S)
	var/obj/structure/smooth/window/W = new(src.loc)
	W.material_id = S.material_id
	W.color = S.color
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)
	caller.to_chat(span("notice","You place \the [W]."))
	S.add_item_count(-4)
	return TRUE

/obj/structure/interactive/construction/grille/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/atom/A = object.defer_click_on_object(location,control,params)

	if(istype(A,/obj/item/material/sheet/glass))
		var/obj/item/material/sheet/S = A
		if(ispath(S.material_id,/material/glass))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_window,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_window,caller,object)
			return TRUE

	return ..()

/obj/structure/interactive/construction/grille/Cross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)
	if(istype(O,/obj/structure/smooth/window/)) //Allow windows to easily fit on grilles.
		return TRUE
	return ..()

/obj/structure/interactive/construction/grille/on_destruction(var/mob/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 2),material_id)
	. = ..()
	qdel(src)
	return .

/obj/structure/interactive/construction/grille/plasteel
	name = "plasteel grille"
	desc = "A plasteel grille."
	color = COLOR_PLASTEEL
	material_id = /material/plasteel
