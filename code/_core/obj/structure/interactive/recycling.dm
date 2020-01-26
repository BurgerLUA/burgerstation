/obj/structure/interactive/recycler
	name = "recycler"
	desc = "Oh god oh fuck."
	desc_extended = "Breaks down components into its most basic parts."
	icon = 'icons/obj/structure/recycling.dmi'
	icon_state = "base"

	var/turf/placing_turf

/obj/structure/interactive/recycler/New(var/desired_loc)

	var/image/I1b = new/image(icon,"grinder_bottom")
	I1b.pixel_x = -TILE_SIZE
	I1b.pixel_y = 0
	overlays += I1b

	var/image/I1 = new/image(icon,"grinder")
	I1.pixel_x = -TILE_SIZE
	I1.pixel_y = 6
	overlays += I1

	pixel_x = TILE_SIZE/2

	return ..()

/obj/structure/interactive/recycler/Initialize()
	placing_turf = get_step(src,EAST)
	return ..()

/obj/structure/interactive/recycler/Crossed(var/atom/movable/O)
	recycle(O)
	return ..()

/obj/structure/interactive/recycler/proc/recycle(var/atom/movable/O)

	if(is_item(O))
		var/obj/item/I = O


		qdel(O)
	else
		O.force_move(placing_turf)




	return TRUE
