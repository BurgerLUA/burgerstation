/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	desc = "null"
	layer = LAYER_OBJ
	plane = PLANE_OBJ

	var/list/additional_blends

	var/should_save = TRUE

	var/under_tile = FALSE

	var/has_quick_function = FALSE

/obj/proc/quick(var/mob/living/advanced/caller,var/atom/object,location,control,params)
	return FALSE

/obj/Destroy()

	if(additional_blends)
		for(var/blend_id in additional_blends)
			var/icon_blend/IB = additional_blends[blend_id]
			qdel(IB)
		additional_blends.Cut()

	loc = null
	return ..()