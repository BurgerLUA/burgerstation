/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	layer = LAYER_OBJ
	plane = PLANE_OBJ

	var/list/additional_blends

	var/should_save = TRUE

	var/under_tile = FALSE

	var/has_quick_function = FALSE
	var/quick_function_type =  FLAG_QUICK_INSTANT
	//FLAG_QUICK_INSTANT
	//FLAG_QUICK_TOGGLE

	var/spawned = FALSE

/obj/Destroy()

	if(additional_blends)
		for(var/blend_id in additional_blends)
			var/icon_blend/IB = additional_blends[blend_id]
			qdel(IB)
		additional_blends.Cut()

	loc = null
	return ..()

/obj/proc/on_spawn() //When the object is spawned on the map or through other generation means.
	spawned = TRUE
	return TRUE