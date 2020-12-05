

//-- Map Placeholders ----------------------------------------------------------

//-- Used to store meta data in dmm files --------
/obj/dmm_suite/comment
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "comment"
	invisibility = 101
	plane = PLANE_HUD
	anchored = 1
	var/coordinates
	var/dimensions
	New()
		. = ..()
		// Must assign at runtime so initial() != runtime when saving
		icon = null
	Finalize()
		qdel(src)

//-- Used in generating turf underlay stacks -----
/turf/dmm_suite/underlay
	New()
		qdel(src)

//-- Fills maps when writing with IGNORE_TURFS ---
/turf/dmm_suite/clear_turf
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "clear_turf"
	New()
		qdel(src)

//-- Fills maps when writing with IGNORE_AREAS ---
/area/dmm_suite/clear_area
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "clear_area"
	New()
		qdel(src)