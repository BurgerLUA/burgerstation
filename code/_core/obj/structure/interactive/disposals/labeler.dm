/obj/structure/interactive/disposals/pipe/labeler
	name = "labeler pipe"
	icon_state = "pipe-l"
	layer = LAYER_FLOOR_PIPE

/obj/structure/interactive/disposals/pipe/labeler/Entered(var/atom/A,var/oldloc)

	if(istype(A,/obj/disposals_container/))
		var/obj/disposals_container/C = A
		C.sorting_tag = sorting_tab_label

	return ..()


/obj/structure/interactive/disposals/pipe/labeler/metal
	sorting_tab_label = "metal"

/obj/structure/interactive/disposals/pipe/labeler/trash
	sorting_tab_label = "trash"