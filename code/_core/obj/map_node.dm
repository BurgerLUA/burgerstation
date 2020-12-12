var/global/list/obj/marker/map_node/all_map_nodes = list()

var/global/mob/abstract/node_checker

/mob/abstract/node_checker
	name = "node checker"
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	layer = LAYER_GHOST
	invisibility = 100
	invisibility = 101
	alpha        = 0
	opacity      = 0
	see_in_dark  = 1e6 // Literally arbitrary.
	density = TRUE

/mob/abstract/node_checker/Bump(atom/Obstacle)
	if(istype(Obstacle,/obj/structure/interactive/door))
		return TRUE
	return ..()

/obj/marker/map_node
	name = "map node"
	icon = 'icons/obj/node.dmi'
	icon_state = "path"
	var/list/adjacent_map_nodes = list()
	invisibility = 0
	anchored = TRUE

/obj/marker/map_node/get_examine_list(var/mob/examiner)
	. = ..()

	for(var/k in adjacent_map_nodes)
		var/obj/marker/map_node/MN = adjacent_map_nodes[k]
		. += div("notice",MN.get_debug_name())

	return .

/obj/marker/map_node/New(var/desired_loc)
	plane = PLANE_HIDDEN
	alpha = 0
	all_map_nodes += src
	return ..()

/obj/marker/map_node/proc/initialize_node()

	var/found = FALSE

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

var/global/list/stored_paths = list()

/obj/marker/map_node/proc/find_path(var/obj/marker/map_node/desired_node,var/obj/marker/map_node/list/checked_nodes = list(),var/obj/marker/map_node/list/current_path=list())

	if(stored_paths["\ref[src],\ref[desired_node]"])
		return stored_paths["\ref[src],\ref[desired_node]"]

	var/is_first = !length(checked_nodes) && !length(current_path)

	current_path = current_path.Copy()

	checked_nodes[src] = TRUE
	current_path += src

	sort_by_closest_assoc(adjacent_map_nodes,desired_node)

	for(var/k in adjacent_map_nodes)
		var/obj/marker/map_node/M = adjacent_map_nodes[k]
		if(M == desired_node)
			return current_path
		if(checked_nodes[M])
			continue
		var/found_path = M.find_path(desired_node,checked_nodes,current_path)
		if(found_path)
			if(is_first)
				found_path += desired_node
				stored_paths["\ref[src],\ref[desired_node]"] = found_path
			return found_path
		sleep(-1)

	return null

/proc/get_obstructions(var/turf/point_A,var/turf/point_B)

	. = list()

	if(!point_A || !point_B)
		return .

	var/mob/abstract/node_checker/NC = new /mob/abstract/node_checker(point_A)
	var/limit = 10
	while(NC.loc != point_B && limit > 0)
		limit--
		CHECK_TICK(75,FPS_SERVER)
		var/desired_dir = get_dir(NC,point_B)
		var/turf/T = get_step(NC,desired_dir)
		if(!T.Enter(NC,NC.loc))
			. |= T
		for(var/k in T.contents)
			var/atom/movable/M = k
			if(!M.Cross(NC))
				. |= M
		NC.loc = T

	qdel(NC)

	return .


/proc/find_closest_node(var/atom/A,var/distance = VIEW_RANGE)

	var/obj/marker/map_node/best_node = null
	var/best_distance = INFINITY

	for(var/obj/marker/map_node/N in range(distance,A))
		var/N_distance = get_dist_real(A,N)
		if(!best_node || best_distance > N_distance)
			best_node = N
			best_distance = N_distance

	return best_node