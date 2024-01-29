/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	desc = "null"
	plane = PLANE_MOVABLE
	layer = LAYER_OBJ

	vis_flags = VIS_INHERIT_PLANE | VIS_INHERIT_ID

	var/list/additional_blends

	var/can_save = TRUE

	var/under_tile = FALSE

	var/has_quick_function = FALSE

/obj/proc/quick(mob/living/advanced/caller,atom/object,location,params)
	return FALSE

/obj/PreDestroy()
	QDEL_CUT_ASSOC(additional_blends)
	. = ..()