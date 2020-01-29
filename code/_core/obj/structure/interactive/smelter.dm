/obj/structure/interactive/smelter
	name = "smelter"
	icon = 'icons/obj/structure/smelter.dmi'
	icon_state = "furnace"

	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/smelter/Initialize()

	pixel_y = 6

	var/image/I1 = new/image(icon,"furnace_left")
	I1.pixel_x = 4 - TILE_SIZE

	var/image/I2 = new/image(icon,"furnace_right")
	I2.pixel_x = TILE_SIZE - 4

	overlays += I1
	overlays += I2

	return ..()

/obj/structure/interactive/smelter/proc/smelt(var/atom/movable/O)

	if(!istype(O,/obj/item/material/ore/))
		return FALSE

	var/obj/item/material/ore/I = O
	var/obj/item/material/ingot/S = new(src.loc)
	S.item_count_current = I.item_count_current
	S.material_id = I.material_id
	S.update_icon()
	qdel(I)

	return

/obj/structure/interactive/smelter/Crossed(var/atom/movable/O)
	smelt(O)
	return ..()