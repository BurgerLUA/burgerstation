/obj/structure/interactive/construction/
	name = "construction object"
	icon = 'icons/obj/structure/construction.dmi'
	mouse_opacity = 2
	var/material_id = "steel"
	color = COLOR_STEEL

	health = /health/construction/

obj/structure/interactive/construction/frame
	name = "frame"
	desc = "A metal frame."
	icon_state = "frame"

	health_base = 25

obj/structure/interactive/construction/frame/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/atom/A = object.defer_click_on_object()

	if(is_item(A))
		var/obj/item/I = A
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			src.on_destruction(caller)
			return TRUE

	if(istype(A,/obj/item/material/rod/))
		var/obj/item/material/rod/R = A
		if(R.material_id != material_id)
			caller.to_chat("You don't have the correct material for this!")
			return TRUE

		if(R.item_count_current >= 2)
			var/obj/structure/interactive/construction/lattice/L = new(src.loc)
			L.material_id = material_id
			L.color = color
			R.item_count_current -= 2
			R.update_sprite()
			caller.to_chat("You place \the [L.name].")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build a lattice!")
		return TRUE

	if(istype(A,/obj/item/material/sheet/))
		if(!istype(src.loc,/turf/simulated/floor/plating/))
			caller.to_chat("You need to build plating before you can build a girder!")
			return TRUE

		var/obj/item/material/sheet/S = A
		if(S.material_id != material_id)
			caller.to_chat("You don't have the correct material for this!")
			return TRUE

		if(S.item_count_current >= 4)
			var/obj/structure/interactive/construction/girder/G = new(src.loc)
			G.material_id = material_id
			G.color = color
			S.item_count_current -= 4
			S.update_sprite()
			caller.to_chat("You place \the [G.name].")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build a girder!")
		return TRUE

	return ..()

obj/structure/interactive/construction/lattice
	name = "lattice"
	desc = "A metal lattice."
	icon_state = "lattice"

	health_base = 50

obj/structure/interactive/construction/lattice/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/atom/A = object.defer_click_on_object()

	if(is_item(A))
		var/obj/item/I = A
		if(I.flags_tool & FLAG_TOOL_WIRECUTTER)
			src.on_destruction(caller)
			return TRUE

	if(istype(A,/obj/item/material/rod/))
		var/obj/item/material/rod/R = A
		if(R.material_id != material_id)
			caller.to_chat("You don't have the correct material for this!")
			return TRUE

		if(R.item_count_current >= 4)
			var/obj/structure/interactive/construction/grille/G = new(src.loc)
			G.material_id = material_id
			G.color = color
			R.item_count_current -= 4
			R.update_sprite()
			caller.to_chat("You place \the [G.name].")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build a lattice!")
		return TRUE

	else if(istype(A,/obj/item/material/sheet/))
		var/obj/item/material/sheet/S = A
		if(S.material_id != material_id)
			caller.to_chat("You don't have the correct material for this!")
			return TRUE

		if(istype(src.loc,/turf/simulated/floor/plating/))
			caller.to_chat("There is already a floor plating here!")
			return TRUE

		if(S.item_count_current >= 4)
			var/turf/T = src.loc
			T.change_turf(/turf/simulated/floor/plating/,TRUE)
			T.color = color
			T.material_id = material_id
			S.item_count_current -= 4
			S.update_sprite()
			caller.to_chat("You place \the plating.")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build floor plating!")
		return TRUE

	return ..()

/obj/structure/interactive/construction/girder
	name = "girder"
	desc = "A metal girder."
	icon_state = "girder"

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	health_base = 100

/obj/structure/interactive/construction/girder/on_destruction(var/atom/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/sheet/ = 2),material_id)
	qdel(src)
	return TRUE


obj/structure/interactive/construction/girder/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/atom/A = object.defer_click_on_object()

	if(istype(A,/obj/item/material/sheet/))
		var/obj/item/material/sheet/S = A
		if(S.material_id != material_id)
			caller.to_chat("You don't have the correct material for this!")
			return TRUE

		if(S.item_count_current >= 4)
			var/turf/T = src.loc
			T.change_turf(/turf/simulated/wall/metal/)
			T.material_id = material_id
			T.color = color
			S.item_count_current -= 4
			S.update_sprite()
			caller.to_chat("You place \the metal wall.")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build a wall!")
		return TRUE


	if(istype(A,/obj/item/material/sheet/))
		var/obj/item/material/sheet/S = A
		if(has_prefix(S.material_id,"glass") && S.item_count_current <= 4)
			var/obj/structure/smooth/window/W = new(src.loc)
			W.material_id = S.material_id
			W.color = S.color
			for(var/obj/structure/smooth/window/W2 in range(2,src))
				W2.update_sprite()
			S.item_count_current -= 4
			caller.to_chat("You place \the [W].")
			S.update_sprite()
			return TRUE

		caller.to_chat("You don't have enough glass sheets to make a window!")
		return TRUE


	return ..()

obj/structure/interactive/construction/grille
	name = "grille"
	desc = "A metal grille."
	icon_state = "grille"

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	health_base = 75

obj/structure/interactive/construction/grille/plasteel
	name = "plasteel grille"
	desc = "A plasteel grille."
	color = COLOR_PLASTEEL
	material_id = "plasteel"

obj/structure/interactive/construction/grille/Cross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(istype(O,/obj/structure/smooth/window/))
		return TRUE

	return ..()

/obj/structure/interactive/construction/grille/on_destruction(var/atom/caller,var/damage = FALSE)
	create_destruction(get_turf(src),list(/obj/item/material/rod/ = 2),material_id)
	qdel(src)
	return TRUE