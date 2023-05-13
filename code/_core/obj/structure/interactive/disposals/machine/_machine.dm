/obj/structure/interactive/disposals/machine/
	plane = PLANE_AREA-1 //Layered above stuff in maps.

/obj/structure/interactive/disposals/machine/Finalize()
	. = ..()
	plane = PLANE_MOVABLE

/obj/structure/interactive/disposals/machine/get_connections()

	. = list()

	.["0"] = TRUE