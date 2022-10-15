var/global/list/obj/marker/map_node/all_map_nodes = list()

/mob/abstract/node_checker
	name = "node checker"
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	plane = PLANE_AREA
	layer = LAYER_GHOST
	invisibility = 101
	alpha        = 0
	opacity      = 0
	mouse_opacity = 0
	see_in_dark  = 1e6 // Literally arbitrary.
	density = TRUE

/mob/abstract/node_checker/Cross(atom/movable/O,atom/oldloc)
	return TRUE

/mob/abstract/node_checker/Bump(atom/Obstacle)
	if(istype(Obstacle,/obj/structure/interactive/door))
		return TRUE
	. = ..()

/obj/marker/map_node
	name = "map node"
	icon = 'icons/obj/node/node_1.dmi'
	icon_state = null
	var/list/adjacent_map_nodes = list()
	invisibility = 100
	anchored = 2

	var/precision = 1 //Lower precision must mean mobs need to be very close to the node in order to count as a pass.

/* RIP failed code.
/obj/marker/map_node/proc/get_dir_to_this(var/atom/M,var/obj/marker/map_node/source_node)

	var/lowest_precision = src.precision - 1
	if(source_node)
		lowest_precision = min(source_node.precision - 1,lowest_precision)

	var/x_offset = M.x - src.x
	var/y_offset = M.y - src.y

	if(x_offset > 0)
		x_offset = max(0,x_offset - lowest_precision)
	else
		x_offset = min(0,x_offset + lowest_precision)

	if(y_offset > 0)
		y_offset = max(0,y_offset - lowest_precision)
	else
		y_offset = min(0,y_offset + lowest_precision)

	if(!x_offset && !y_offset)
		return null

	var/found_angle = MODULUS(ATAN2(x_offset,y_offset) + 90,360)

	return angle2dir_cardinal(found_angle)


/obj/marker/map_node/proc/get_dist_to(var/atom/M)

	var/lowest_precision = src.precision - 1

	var/x_offset = M.x - src.x
	var/y_offset = M.y - src.y

	if(x_offset > 0)
		x_offset = max(0,x_offset - lowest_precision)
	else
		x_offset = min(0,x_offset + lowest_precision)

	if(y_offset > 0)
		y_offset = max(0,y_offset - lowest_precision)
	else
		y_offset = min(0,y_offset + lowest_precision)

	return max(abs(x_offset),abs(y_offset))
*/


/obj/marker/map_node/get_examine_list(var/mob/examiner)

	. = ..()

	for(var/k in adjacent_map_nodes)
		var/obj/marker/map_node/MN = adjacent_map_nodes[k]
		. += div("notice",MN.get_debug_name())

/obj/marker/map_node/New(var/desired_loc)
	. = ..()
	all_map_nodes += src

/obj/marker/map_node/Destroy()
	. = ..()
	all_map_nodes -= src

/obj/marker/map_node/proc/initialize_node()

	var/found = FALSE
	for(var/obj/marker/map_node/M in orange(VIEW_RANGE*2,src))
		var/direction = dir2text(get_dir(src,M))
		if(src.adjacent_map_nodes[direction] && get_dist_real(src,M) > get_dist_real(src,src.adjacent_map_nodes[direction]))
			continue
		var/list/obstructions = get_obstructions(src,M) + get_obstructions(M,src)
		if(length(obstructions) > 0)
			continue
		src.adjacent_map_nodes[direction] = M
		found = TRUE

	if(!found)
		log_error("Invalid node! [src.get_debug_name()].")

	return found


/proc/get_obstructions(var/atom/point_A,var/atom/point_B,var/check_contents=TRUE) //Supports point_B being a node

	. = list()

	if(!point_A || !point_B) return .

	var/mob/abstract/node_checker/node_checker = new(get_turf(point_A))

	var/desired_distance = 0
	if(istype(point_B,/obj/marker/map_node))
		var/obj/marker/map_node/MN = point_B
		desired_distance = MN.precision

	var/limit = VIEW_RANGE*2
	while(get_dist(node_checker,point_B) > desired_distance && limit > 0)
		limit--
		CHECK_TICK_SAFE(75,FPS_SERVER)
		var/desired_dir = get_dir(node_checker,point_B)
		var/turf/T
		if(is_intercardinal_dir(desired_dir))
			var/first_move_dir_to_use = get_true_4dir(desired_dir)
			var/second_move_dir_to_use = desired_dir & ~first_move_dir_to_use
			var/turf/first_step = get_step(node_checker,first_move_dir_to_use)
			var/turf/second_step = get_step(node_checker,second_move_dir_to_use)
			if(!first_step || !(first_step.Enter(node_checker,node_checker.loc) || first_step.Enter(node_checker,second_step)))
				desired_dir &= ~first_move_dir_to_use
			if(!second_step || !(second_step.Enter(node_checker,node_checker.loc) || second_step.Enter(node_checker,first_step)))
				desired_dir &= ~second_move_dir_to_use
			if(!desired_dir)
				break
			T = get_step(node_checker,desired_dir)
		else
			T = get_step(node_checker,desired_dir)
		if(!T) break
		if(T.density && !T.Enter(node_checker,node_checker.loc))
			. |= T
		if(check_contents && T.has_dense_atom)
			for(var/k in T.contents)
				var/atom/movable/M = k
				if(!M.allow_path && M.density && M.anchored && !M.Cross(node_checker,node_checker.loc))
					. |= M

		node_checker.loc = T

	qdel(node_checker)



/proc/find_closest_node(var/atom/A,var/distance = VIEW_RANGE,var/check_view=FALSE)

	var/obj/marker/map_node/best_node = null
	var/best_distance = INFINITY

	if(check_view)
		for(var/obj/marker/map_node/N in view(distance,A))
			var/N_distance = get_dist(A,N)
			if(!best_node || best_distance > N_distance)
				best_node = N
				best_distance = N_distance
	else
		for(var/obj/marker/map_node/N in range(distance,A))
			var/N_distance = get_dist(A,N)
			if(!best_node || best_distance > N_distance)
				best_node = N
				best_distance = N_distance

	return best_node


/obj/marker/map_node/x2
	icon = 'icons/obj/node/node_2.dmi'
	precision = 2
	pixel_x = -TILE_SIZE*(2-1)
	pixel_y = -TILE_SIZE*(2-1)

/obj/marker/map_node/x3
	icon = 'icons/obj/node/node_3.dmi'
	precision = 3
	pixel_x = -TILE_SIZE*(3-1)
	pixel_y = -TILE_SIZE*(3-1)

/obj/marker/map_node/x4
	icon = 'icons/obj/node/node_4.dmi'
	precision = 4
	pixel_x = -TILE_SIZE*(4-1)
	pixel_y = -TILE_SIZE*(4-1)

/obj/marker/map_node/x5
	icon = 'icons/obj/node/node_5.dmi'
	precision = 5
	pixel_x = -TILE_SIZE*(5-1)
	pixel_y = -TILE_SIZE*(5-1)