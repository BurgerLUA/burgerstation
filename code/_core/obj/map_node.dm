var/global/list/obj/marker/map_node/all_map_nodes = list()

var/global/mob/abstract/node_checker

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
	icon = 'icons/obj/node.dmi'
	icon_state = "path"
	var/list/adjacent_map_nodes = list()
	invisibility = 0
	anchored = 2

	var/precision = 4 //Lower precision must mean mobs need to be very close to the node in order to count as a pass.

/obj/marker/map_node/get_examine_list(var/mob/examiner)

	. = ..()

	for(var/k in adjacent_map_nodes)
		var/obj/marker/map_node/MN = adjacent_map_nodes[k]
		. += div("notice",MN.get_debug_name())

/obj/marker/map_node/New(var/desired_loc)
	plane = PLANE_HIDDEN
	alpha = 0
	all_map_nodes += src
	return ..()

/obj/marker/map_node/proc/initialize_node()

	var/found = FALSE

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = src
		for(var/i=1,i<=precision,i++)
			T = get_step(T,d)
			if(T.has_dense_atom)
				precision = i
				break
		if(precision <= 1)
			break

	for(var/obj/marker/map_node/M in orange(VIEW_RANGE,src))
		var/mob/abstract/node_checker/NC = node_checker
		NC.loc = src.loc
		var/invalid = FALSE
		while(TRUE)
			var/desired_dir = get_dir(NC,M)
			if(!step(NC,desired_dir))
				invalid = TRUE
				break
			if(NC.loc == M.loc)
				break
		if(invalid)
			continue
		var/direction = dir2text(get_dir(src,M))
		if(src.adjacent_map_nodes[direction] && get_dist(src,M) > get_dist(src,src.adjacent_map_nodes[direction]))
			continue
		src.adjacent_map_nodes[direction] = M
		found = TRUE

	if(!found)
		log_error("Invalid node! [src.get_debug_name()].")

	return found

/proc/get_obstructions(var/turf/point_A,var/turf/point_B)

	. = list()

	if(!point_A || !point_B) return .

	node_checker.force_move(point_A)

	var/limit = 10
	while(node_checker.loc != point_B && limit > 0)
		limit--
		CHECK_TICK_SAFE(75,FPS_SERVER)
		var/desired_dir = get_dir(node_checker,point_B)
		var/turf/T = get_step(node_checker,desired_dir)
		if(T.density && !T.Enter(node_checker,node_checker.loc))
			. |= T
		if(T.has_dense_atom)
			for(var/k in T.contents)
				var/atom/movable/M = k
				if(!M.allow_path && M.density && M.anchored && !M.Cross(node_checker,node_checker.loc))
					. |= M
		node_checker.loc = T

	node_checker.force_move(null)



/proc/find_closest_node(var/atom/A,var/distance = VIEW_RANGE,var/check_view=FALSE)

	var/obj/marker/map_node/best_node = null
	var/best_distance = INFINITY

	if(check_view)
		for(var/obj/marker/map_node/N in view(distance,A))
			var/N_distance = get_dist_real(A,N)
			if(!best_node || best_distance > N_distance)
				best_node = N
				best_distance = N_distance
	else
		for(var/obj/marker/map_node/N in range(distance,A))
			var/N_distance = get_dist_real(A,N)
			if(!best_node || best_distance > N_distance)
				best_node = N
				best_distance = N_distance

	return best_node