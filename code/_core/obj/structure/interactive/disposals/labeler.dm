/obj/structure/interactive/disposals/pipe/labeler
	name = "labeler pipe"
	icon_state = "pipe-l"
	layer = LAYER_FLOOR_PIPE

	var/sorting_tag_label = null //If this goes into the pipe, give it a label if any.
	var/sorting_tag_label_partial = null //Partial labeler. If this tag

/obj/structure/interactive/disposals/pipe/labeler/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/disposals/pipe/labeler/update_sprite()

	if(sorting_tag_label)
		name = "[initial(name)] ([sorting_tag_label])"
	else
		name = initial(name)

	. = ..()

/obj/structure/interactive/disposals/pipe/labeler/Entered(atom/movable/Obj,atom/OldLoc)

	if(istype(Obj,/obj/disposals_container/))
		var/obj/disposals_container/C = Obj
		if(sorting_tag_label)
			C.sorting_tag = sorting_tag_label
		else if(sorting_tag_label_partial)
			if(C.sorting_tag_partial == sorting_tag_label_partial)
				C.sorting_tag = sorting_tag_label_partial
				C.sorting_tag_partial = null
			else
				C.sorting_tag_partial = sorting_tag_label_partial

	. = ..()

/obj/structure/interactive/disposals/pipe/labeler/partial
	name = "partial labeler pipe"