/obj/effect/slime_ball
	name = "slime ball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "slime_ball_tri"

	var/moves_left = 5

	glide_size = TILE_SIZE


/obj/effect/slime_ball/proc/do_moveset()

	var/turf/T = get_step(src,dir)
	if(!T)
		qdel(src)
		return TRUE

	if(!src.Move(T))
		qdel(src)
		return TRUE
