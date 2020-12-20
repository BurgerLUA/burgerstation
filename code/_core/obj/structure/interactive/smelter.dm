/obj/structure/interactive/smelter
	name = "smelter"
	desc = "A furnace used to smelt ores"
	desc_extended = "Ore that goes from one side via conveyor comes out smelted into ingots out the other."
	icon = 'icons/obj/structure/smelter.dmi'
	icon_state = "furnace"

	plane = PLANE_OBJ

	pixel_y = 2

	bullet_block_chance = 50

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFF00"

/obj/structure/interactive/smelter/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/smelter/update_overlays()

	. = ..()

	pixel_y = 6

	var/image/I1 = new/image(icon,"furnace_left")
	I1.pixel_x = 4 - TILE_SIZE

	var/image/I2 = new/image(icon,"furnace_right")
	I2.pixel_x = TILE_SIZE - 4

	add_overlay(I1)
	add_overlay(I2)

	return .

/obj/structure/interactive/smelter/proc/smelt(var/atom/movable/O)

	if(!istype(O,/obj/item/material/ore/))
		return FALSE

	var/obj/item/material/ore/I = O
	var/obj/item/material/ingot/S = new(src.loc)
	S.item_count_current = I.item_count_current
	S.material_id = I.material_id
	INITIALIZE(S)
	GENERATE(S)
	FINALIZE(S)
	qdel(I)

	return

/obj/structure/interactive/smelter/Crossed(atom/movable/O)
	smelt(O)
	return ..()