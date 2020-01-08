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
			R.update_icon()
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
			S.update_icon()
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
			R.update_icon()
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
			S.update_icon()
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

	var/desired_dir = get_dir(src,caller)
	var/turf/desired_turf = get_step(src,desired_dir)

	for(var/i=1,i<=2,i++)

		var/obj/item/material/sheet/S = new(desired_turf)
		S.material_id = material_id
		S.color = color

		var/offset_x = 0
		var/offset_y = 0

		if(desired_dir & NORTH)
			offset_y -= TILE_SIZE

		if(desired_dir & SOUTH)
			offset_y += TILE_SIZE

		if(desired_dir & EAST)
			offset_x -= TILE_SIZE

		if(desired_dir & WEST)
			offset_x += TILE_SIZE

		S.pixel_x = offset_x
		S.pixel_y = offset_y

		animate(S,pixel_x = rand(-TILE_SIZE*0.5,TILE_SIZE*0.5), pixel_y = rand(-TILE_SIZE*0.5,TILE_SIZE*0.5),time=5)

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
			S.update_icon()
			caller.to_chat("You place \the metal wall.")
			qdel(src)
			return TRUE

		caller.to_chat("You don't have enough material to build a wall!")
		return TRUE

	return ..()

obj/structure/interactive/construction/grille
	name = "grille"
	desc = "A metal grille."
	icon_state = "grille"

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	health_base = 75

obj/structure/interactive/construction/grille/Cross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(istype(O,/obj/structure/smooth/window/))
		return TRUE

	return ..()
