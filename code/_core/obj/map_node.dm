var/global/list/obj/marker/map_node/all_map_nodes = list()

var/global/mob/abstract/node_checker


/mob/abstract/node_checker
	name = "node checker"
	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	layer = LAYER_GHOST
	invisibility = 101

/mob/abstract/node_checker/New(var/desired_loc)
	node_checker = src
	return ..()

/mob/abstract/node_checker/Bump(atom/movable/O)
	return !isturf(O) && !is_wall(O)

/obj/marker/map_node
	name = "map node"
	icon = 'icons/obj/node.dmi'
	icon_state = "path"
	var/list/adjacent_map_nodes = list()

/obj/marker/map_node/New(var/desired_loc)
	all_map_nodes += src
	return ..()

/obj/marker/map_node/proc/initialize_node()

	var/found = FALSE

	for(var/obj/marker/map_node/M in oview(VIEW_RANGE*2,src))
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
			sleep(-1)
		if(invalid)
			continue
		src.adjacent_map_nodes += M
		found = TRUE

	if(!found)
		log_error("WARNING: Node at [src.x], [src.y], [src.z] is invalid!")

	return found

var/global/list/stored_paths = list()

/obj/marker/map_node/proc/find_path(var/obj/marker/map_node/desired_node,var/obj/marker/map_node/list/checked_nodes = list(),var/obj/marker/map_node/list/current_path=list())

	if(stored_paths["\ref[src],\ref[desired_node]"])
		return stored_paths["\ref[src],\ref[desired_node]"]

	var/is_first = !length(checked_nodes) && !length(current_path)

	current_path = current_path.Copy()

	checked_nodes[src] = TRUE
	current_path += src

	sort_by_closest(adjacent_map_nodes,desired_node)

	for(var/obj/marker/map_node/M in adjacent_map_nodes)
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

/proc/find_closest_node(var/atom/A,var/distance = VIEW_RANGE*2,var/debug = FALSE)

	var/obj/marker/map_node/best_node = null
	var/best_distance = INFINITY

	for(var/obj/marker/map_node/N in range(distance,A))
		var/N_distance = get_dist_real(A,N)
		if(!best_node || best_distance > N_distance)
			best_node = N
			best_distance = N_distance


	return best_node


var/global/obj/marker/map_node/list/last_path = list()

/*
client/verb/paint_best_path()

	if(last_path)
		for(var/obj/marker/map_node/M in last_path)
			color = "#FFFFFF"
			M.maptext = null
		last_path.Cut()

	var/mob/living/advanced/npc/beefman/B = locate() in world

	var/obj/marker/map_node/N_start = find_closest_node(B)
	if(!N_start)
		LOG_DEBUG("CAN'T FIND START!")
		return FALSE

	var/obj/marker/map_node/N_end = find_closest_node(src.mob,debug = TRUE)
	if(!N_end)
		LOG_DEBUG("CAN'T FIND END!")
		return FALSE

	var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)

	if(!found_path || !length(found_path))
		LOG_DEBUG("CAN'T FIND PATH!")
		return FALSE

	B.ai.set_path(found_path)


	var/i=1
	for(var/obj/marker/map_node/M in found_path)
		M.color = "#FF0000"
		M.maptext = "[i]"
		M.desc = "Distance to goal: [get_dist_real(M,N_end)]."
		//src.mob.force_move(M.loc)
		sleep(1)
		i++
*/


client/verb/summon_syndicate()

	var/obj/marker/map_node/N_end = find_closest_node(src.mob,debug = TRUE)
	if(!N_end)
		LOG_DEBUG("CAN'T FIND END!")
		return FALSE

	for(var/mob/living/advanced/npc/syndicate/S in world)
		var/obj/marker/map_node/N_start = find_closest_node(S)
		if(!N_start)
			LOG_DEBUG("CAN'T FIND START!")
			continue

		var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)

		if(!found_path || !length(found_path))
			LOG_DEBUG("CAN'T FIND PATH!")
			continue

		S.ai.set_path(found_path)