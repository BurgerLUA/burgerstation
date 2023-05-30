/obj/structure/interactive/recycler
	name = "recycler"
	desc = "Oh god oh fuck."
	desc_extended = "Breaks down components into its most basic parts."
	icon = 'icons/obj/structure/recycling.dmi'
	icon_state = "base"

	var/turf/placing_turf

	var/list/stored_material = list()

	plane = PLANE_MOVABLE

	bullet_block_chance = 50

	density = TRUE

/obj/structure/interactive/recycler/Destroy()
	placing_turf = null
	. = ..()

/obj/structure/interactive/recycler/New(var/desired_loc)

	var/image/I1b = new/image(icon,"grinder_bottom")
	I1b.pixel_x = -TILE_SIZE
	I1b.pixel_y = 0
	add_overlay(I1b)

	var/image/I1 = new/image(icon,"grinder")
	I1.pixel_x = -TILE_SIZE
	I1.pixel_y = 6
	add_overlay(I1)

	pixel_x = TILE_SIZE/2

	return ..()

/obj/structure/interactive/recycler/Initialize()
	placing_turf = get_step(src,EAST)
	return ..()

/obj/structure/interactive/recycler/Crossed(atom/movable/O,atom/OldLoc)
	recycle(O)
	. = ..()

/obj/structure/interactive/recycler/proc/recycle(var/atom/movable/O,var/process = TRUE)

	if(is_item(O))
		var/obj/item/I = O
		for(var/k in I.contents)
			recycle(k,FALSE)
		if(is_material(I))
			var/obj/item/material/M = I
			stored_material[M.material_id] += M.amount*M.material_multiplier
		qdel(O)
		if(process) process_material()
		return TRUE

	if(is_living(O))
		var/mob/living/L = O
		if(!L.dead || L.loyalty_tag == "NanoTrasen")
			return FALSE
		L.on_butcher(null,null,override_turf = placing_turf)
		return TRUE

	O.force_move(placing_turf)

	return TRUE


/obj/structure/interactive/recycler/proc/process_material()

	for(var/material_type in stored_material)
		var/material_value = stored_material[material_type]
		if(material_value < 1)
			continue
		stored_material[material_type] -= FLOOR(material_value,1)
		var/obj/item/material/trash_cube/S = new(placing_turf)
		S.amount = material_value
		S.material_id = material_type
		INITIALIZE(S)
		FINALIZE(S)

	return TRUE
