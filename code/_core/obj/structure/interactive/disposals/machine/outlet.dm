/obj/structure/interactive/disposals/machine/outlet
	name = "disposals outlet"
	desc = "Express delivery!"
	desc_extended = "Stuff going trough disposals comes out here."
	icon_state = "outlet"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	var/throw_accuracy = 0
	var/throw_velocity = 10
	var/throw_range_min = 2
	var/throw_range_max = 3

	plane = PLANE_OBJ

	bullet_block_chance = 50

	density = TRUE

/obj/structure/interactive/disposals/machine/outlet/Entered(var/atom/A,var/oldloc)

	if(istype(A,/obj/disposals_container/))

		var/obj/disposals_container/C = A

		var/list/throw_offset = direction_to_pixel_offset(dir)

		for(var/atom/movable/M in C.contents)

			if(M.anchored || M.grabbing_hand || M.collision_flags & FLAG_COLLISION_ETHEREAL)
				M.force_move(src.loc)
				continue

			var/diff_x = throw_offset[1] + RAND_PRECISE(-throw_accuracy,throw_accuracy)
			var/diff_y = throw_offset[2] + RAND_PRECISE(-throw_accuracy,throw_accuracy)

			var/highest = max(abs(diff_x),abs(diff_y))

			if(highest > 0)
				diff_x = diff_x/highest
				diff_y = diff_y/highest
			else
				diff_x = throw_offset[1]
				diff_y = throw_offset[2]
			M.force_move(get_step(src,dir))
			var/obj/projectile/bullet/thrown/P = M.throw_self(src,null,null,null,diff_x*throw_velocity,diff_y*throw_velocity)
			P.steps_allowed = rand(throw_range_min,throw_range_max)

		qdel(C)

	return ..()

/obj/structure/interactive/disposals/machine/outlet/random
	throw_accuracy = 0.5
	throw_range_min = 3
	throw_range_max = 7