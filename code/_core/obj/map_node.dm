var/global/list/obj/map_node/all_map_nodes = list()

/obj/map_node
	name = "map node"
	var/list/obj/map_node/adjacent_nodes
	//var/list/obj/map_node/linked_nodes
	icon = 'icons/obj/node.dmi'
	icon_state = "path"

/obj/map_node/New(var/desired_loc)
	all_map_nodes += src
	return ..()

/obj/map_node/proc/initialize_node()
	adjacent_nodes = list()
	for(var/obj/map_node/M in oview(VIEW_RANGE,src))
		adjacent_nodes += M
	return TRUE

/obj/map_node/proc/find_path(var/obj/map_node/desired_node,var/obj/map_node/list/checked_nodes = list(),var/obj/map_node/list/current_path=list())

	current_path = current_path.Copy()

	checked_nodes[src] = TRUE
	current_path += src

	var/list/sorted_map_nodes = list()

	for(var/obj/map_node/M in oview(VIEW_RANGE*2,src))
		sorted_map_nodes[M] = -get_dist(src,desired_node)

	InsertionSort(sorted_map_nodes)

	for(var/obj/map_node/M in sorted_map_nodes)
		if(checked_nodes[M])
			continue
		if(M == desired_node)
			return current_path
		var/found_path = M.find_path(desired_node,checked_nodes,current_path)
		if(found_path)
			found_path += desired_node
			return found_path

	return null

/proc/find_closest_node(var/atom/A,var/distance = VIEW_RANGE)

	var/best_node = null
	var/best_distance = INFINITY

	for(var/obj/map_node/N in view(distance,A))
		if(!best_node)
			best_node = N
			continue
		var/current_distance = get_dist(src,N)
		if(current_distance < best_distance)
			best_distance = current_distance
			best_node = N

	return best_node

client/verb/paint_best_path()

	var/obj/map_node/N_start = find_closest_node(src.mob)
	if(!N_start)
		LOG_DEBUG("CAN'T FIND START!")
		return FALSE

	var/mob/living/advanced/npc/beefman/B = locate() in world
	var/obj/map_node/N_end = find_closest_node(B)
	if(!N_end)
		LOG_DEBUG("CAN'T FIND END!")
		return FALSE

	var/obj/map_node/list/found_path = N_start.find_path(N_end)

	if(!found_path || !length(found_path))
		LOG_DEBUG("CAN'T FIND PATH!")
		return FALSE

	for(var/obj/map_node/M in found_path)
		M.color = "#FF0000"
		spawn(100)
			M.color = "#FFFFFF"