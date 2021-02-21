var/global/list/obj/marker/chasm_fall/all_fall_markers = list()

/obj/marker/chasm_fall
	name = "chasm fall marker"
	desc = "Where people fall when they step into a chasm."

/obj/marker/chasm_fall/Initialize()
	. = ..()
	all_fall_markers += src
	