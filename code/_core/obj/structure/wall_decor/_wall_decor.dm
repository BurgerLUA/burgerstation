/obj/structure/wall_decor
	name = "wall decor"
	mouse_opacity = 0
	plane = PLANE_WALL
	layer = 500

/obj/structure/wall_decor/Finalize()
	. = ..()
	var/turf/T = get_turf(src)
	if(!is_wall(T))
		qdel(src)
	if(T.health)
		HOOK_ADD("change_turf","\ref[src]_change_turf_remove",T,src,.proc/remove_wall_decor)

/obj/structure/wall_decor/proc/remove_wall_decor()
	qdel(src)
	return TRUE