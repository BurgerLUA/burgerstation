/obj/structure/interactive/construction/grille
	name = "grille"
	desc = "A metal grille."
	desc_extended = "Could probably add some glass for a window."
	icon_state = "grille"

	icon = 'icons/obj/structure/grille.dmi'
	icon_state = "grille"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	density = TRUE

	corner_category = "grille"
	corner_icons = TRUE

	health_base = 75

	plane = PLANE_WALL

	bullet_block_chance = 50

	layer = LAYER_OBJ_WINDOW - 0.1

/obj/structure/interactive/construction/grille/proc/can_construct_window(var/mob/activator,var/obj/item/material/sheet/S)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(S)

	if(istype(src.loc,/obj/structure/window/))
		activator.to_chat(span("warning","There is already a window here!"))
		return FALSE
	if(S.amount < 1)
		activator.to_chat(span("warning","You need a glass sheet in order to build a wall!"))
		return FALSE
	return TRUE

/obj/structure/interactive/construction/grille/proc/construct_window(var/mob/activator,var/obj/item/material/sheet/S)
	var/obj/structure/window/W = new(src.loc)
	W.material_id = S.material_id
	W.color = S.color
	INITIALIZE(W)
	GENERATE(W)
	FINALIZE(W)
	activator?.visible_message(span("notice","\The [activator.name] places \the [W.name]."),span("notice","You place \the [W.name]."))
	S.add_item_count(-1)
	return TRUE

/obj/structure/interactive/construction/grille/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			if(src.can_do_destruction(FALSE))
				activator.to_chat(span("notice","You dissasemble the [src.name]"))
				src.on_destruction(FALSE)
			return TRUE
	if(istype(object,/obj/item/material/sheet))
		var/obj/item/material/sheet/S = object
		if(ispath(S.material_id,/material/glass))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(10)
			PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(3),src::construct_window(),activator,object)
			PROGRESS_BAR_CONDITIONS(activator,src,src::can_construct_window(),activator,object)
			return TRUE

	return ..()

/obj/structure/interactive/construction/grille/Cross(atom/movable/O,atom/oldloc)
	if(istype(O,/obj/structure/window/)) //Allow windows to easily fit on grilles.
		return TRUE
	return ..()

/obj/structure/interactive/construction/grille/on_destruction(var/damage = TRUE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 2),material_id)
	. = ..()
	qdel(src)

/obj/structure/interactive/construction/grille/plasteel
	name = "plasteel grille"
	desc = "A plasteel grille."
	color = COLOR_PLASTEEL
	material_id = /material/plasteel
