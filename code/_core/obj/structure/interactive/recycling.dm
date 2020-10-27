/obj/structure/interactive/recycler
	name = "recycler"
	desc = "Oh god oh fuck."
	desc_extended = "Breaks down components into its most basic parts."
	icon = 'icons/obj/structure/recycling.dmi'
	icon_state = "base"

	var/turf/placing_turf

	var/list/stored_material = list()

	plane = PLANE_OBJ

	bullet_block_chance = 50

	density = TRUE

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

/obj/structure/interactive/recycler/Crossed(atom/movable/O)
	recycle(O)
	return ..()

/obj/structure/interactive/recycler/proc/recycle(var/atom/movable/O,var/process = TRUE)

	if(is_item(O))
		var/obj/item/I = O
		for(var/material_type in I.material)
			stored_material[material_type] += I.material[material_type]

		for(var/obj/item/I2 in I.contents) //Non-items will be deleted anyways.
			recycle(I2,FALSE)

		if(process)
			process_material()

		qdel(O)

	else
		O.force_move(placing_turf)

	return TRUE


/obj/structure/interactive/recycler/proc/process_material()

	for(var/material_type in stored_material)
		var/material_value = stored_material[material_type]
		var/material_to_make = FLOOR(material_value/1000, 1)
		if(material_to_make < 1)
			continue
		stored_material[material_type] -= material_to_make*1000
		var/obj/item/material/trash_cube/S = new(placing_turf)
		S.item_count_current = material_to_make
		S.material_id = material_type
		INITIALIZE(S)
		FINALIZE(S)

	return TRUE
