/obj/structure/interactive/construction/grille
	name = "grille"
	desc = "A metal grille."
	icon_state = "grille"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	density = TRUE

	health_base = 75

	plane = PLANE_WALL

	bullet_block_chance = 50

	layer = LAYER_OBJ_WINDOW - 0.1

/obj/structure/interactive/construction/grille/proc/can_construct_window(var/mob/caller,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/obj/structure/smooth/window/))
		caller.to_chat(span("warning","There is already a window here!"))
		return FALSE
	if(S.item_count_current < 4)
		caller.to_chat(span("warning","You need 4 glass sheets in order to build a wall!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/grille/proc/construct_window(var/mob/caller,var/obj/item/material/sheet/S)
	var/obj/structure/smooth/window/W = new(src.loc)
	W.material_id = S.material_id
	W.color = S.color
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)
	caller?.visible_message(span("notice","\The [caller.name] places \the [W.name]."),span("notice","You place \the [W.name]."))
	S.add_item_count(-4)
	return TRUE

/obj/structure/interactive/construction/grille/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)




	if(istype(object,/obj/item/material/sheet))
		var/obj/item/material/sheet/S = object
		if(ispath(S.material_id,/material/glass))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/construct_window,caller,object)
			PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_construct_window,caller,object)
			return TRUE

	return ..()

/obj/structure/interactive/construction/grille/Cross(atom/movable/O)
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
