

//-- Map Placeholders ----------------------------------------------------------

/turf/dmm_suite/
	invisibility = 0

//-- Used in generating turf underlay stacks -----
/turf/dmm_suite/underlay

//-- Fills maps when writing with IGNORE_TURFS ---
/turf/dmm_suite/clear_turf
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "clear_turf"

//-- Destroys walls underneath, if any. ----------
/turf/dmm_suite/no_wall
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "no_wall"

/area/dmm_suite
	invisibility = 0

//-- Fills maps when writing with IGNORE_AREAS ---
/area/dmm_suite/clear_area
	name = "CLEAR AREA"
	icon = 'icons/obj/markers/map_editor.dmi'
	icon_state = "clear_area"