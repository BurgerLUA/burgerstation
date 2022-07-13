/*
AStar pathfinding from Goonstation.
Credit:
 ZeWaka
 pali6
 Tarmunora
 Adharainspace
 Sovexe
 Xkeeper0
 Superlagg
 mordent-goonstation
 zjdtmkhzt

Some code modified to work with Burgerstation.
*/

/*
/proc/AStar(turf/start, turf/end, atom/movable/walker, maxtraverse = 30)
	if(!isturf(start) || !isturf(end))
		return
	var/list/turf/open = list(start)
	var/list/turf/nodeParent = list()
	var/list/nodeGcost = list()

	var/traverseNum = 0
	while (traverseNum++ < length(open))
		var/turf/current = open[traverseNum]
		var/tentativeGScore = nodeGcost[current]
		if (current == end)
			var/list/reconstructed_path = list()
			while(current)
				reconstructed_path.Insert(1, current)
				current = nodeParent[current]
			return reconstructed_path

		var/list/neighbors = current.get_crossable_neighbors(walker,TRUE,TRUE)
		for (var/neighbor in neighbors)
			if (neighbor in open)
				continue
			var/gScore = tentativeGScore + neighbors[neighbor]

			for (var/i = traverseNum; i <= length(open);)
				if (i++ == length(open) || open[open[i]] >= gScore)
					open.Insert(i, neighbor)
					open[neighbor] = gScore
					break
			nodeGcost[neighbor] = gScore
			nodeParent[neighbor] = current

		if (traverseNum > maxtraverse)
			return null // if we reach this part, there's no more nodes left to explore
*/


/proc/AStar_Circle(turf/start, turf/goal, atom/movable/walker, min_dist=0, maxtraverse=30)

	var/list/turf/closedSet = list()
	var/list/turf/openSet = list(start)
	var/list/turf/cameFrom = list()

	var/list/gScore = list()
	var/list/fScore = list()
	gScore[start] = 0
	fScore[start] = get_dist(start, goal)
	var/traverse = 0

	while(length(openSet))
		var/turf/current = pick_lowest(openSet, fScore)
		if(get_dist(current, goal) <= min_dist)
			return reconstruct_path(cameFrom, current)

		openSet -= current
		closedSet += current
		var/list/turf/neighbors = current.get_crossable_neighbors(walker,TRUE,TRUE)
		for(var/turf/neighbor as anything in neighbors)
			if(neighbor in closedSet)
				continue // already checked this one
			var/tentativeGScore = gScore[current] + get_dist(current, neighbor)
			if(!(neighbor in openSet))
				openSet += neighbor
			else if(tentativeGScore >= (gScore[neighbor] || 1.#INF))
				continue // this is not a better route to this node

			cameFrom[neighbor] = current
			gScore[neighbor] = tentativeGScore
			fScore[neighbor] = gScore[neighbor] + get_dist(neighbor, goal)
		traverse += 1
		if(traverse > maxtraverse)
			return null // it's taking too long, abandon
	return null // if we reach this part, there's no more nodes left to explore


/proc/pick_lowest(list/options, list/values)
	if(!length(options))
		return null // you idiot
	var/lowestScore = 1.#INF
	for(var/option in options)
		if(option in values)
			var/score = values[option]
			if(score < lowestScore)
				lowestScore = score
				. = option

/proc/reconstruct_path(list/cameFrom, current)
	var/list/totalPath = list(current)
	while(current in cameFrom)
		current = cameFrom[current]
		totalPath += current
	// reverse the path
	. = list()
	for(var/i = length(totalPath) to 1 step -1)
		. += totalPath[i]
	return .



/proc/AStar_Circle_node(var/obj/marker/map_node/start, var/obj/marker/map_node/goal, var/atom/movable/walker, min_dist=0, maxtraverse=100,var/debug=FALSE)

	var/list/obj/marker/map_node/closedSet = list()
	var/list/obj/marker/map_node/openSet = list(start)
	var/list/obj/marker/map_node/cameFrom = list()

	var/list/gScore = list()
	var/list/fScore = list()
	gScore[start] = 0
	fScore[start] = get_dist(start, goal)
	var/traverse = 0

	while(length(openSet))
		var/obj/marker/map_node/current = pick_lowest(openSet, fScore)
		if(get_dist(current, goal) <= min_dist)
			if(debug) log_debug("AStar_Circle_node: Reconstructing path...")
			return reconstruct_path(cameFrom, current)

		openSet -= current
		closedSet += current
		var/list/obj/marker/map_node/neighbors = list()
		for(var/d in current.adjacent_map_nodes)
			neighbors += current.adjacent_map_nodes[d]

		for(var/obj/marker/map_node/neighbor as anything in neighbors)
			if(neighbor in closedSet)
				continue // already checked this one
			var/tentativeGScore = gScore[current] + get_dist(current, neighbor)
			if(!(neighbor in openSet))
				openSet += neighbor
			else if(tentativeGScore >= (gScore[neighbor] || 1.#INF))
				continue // this is not a better route to this node

			cameFrom[neighbor] = current
			gScore[neighbor] = tentativeGScore
			fScore[neighbor] = gScore[neighbor] + get_dist(neighbor, goal)
		traverse += 1
		if(traverse > maxtraverse)
			if(debug) log_debug("AStar_Circle_node: Maximum traverse reached...")
			return null // it's taking too long, abandon
	return null // if we reach this part, there's no more nodes left to explore