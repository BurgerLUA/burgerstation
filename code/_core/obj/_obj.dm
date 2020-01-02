/obj/
	name = "OBJ ERROR"
	icon = 'icons/debug/objs.dmi'
	icon_state = ""
	layer = LAYER_OBJ
	plane = PLANE_OBJ

	var/list/additional_blends

	var/should_save = TRUE

/obj/Destroy()

	for(var/blend_id in additional_blends)
		var/icon_blend/IB = additional_blends[blend_id]
		qdel(IB)

	if(additional_blends)
		additional_blends.Cut()

	if(loc)
		drop_item()
	loc = null
	return ..()

/obj/proc/on_spawn() //When the object is spawned on the map and not loaded.
	return TRUE