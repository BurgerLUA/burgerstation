//Credit to Xirre for all this.

/obj/node/
	name = "AI Node."
	desc = "An AI node for long range pathing."

/node_search/
	var/obj/node/pos
	var/is_dense = FALSE
	var/list/node_search/neighbors
	var/node_search/parent
	var/in_open_list = FALSE
	var/in_closed_list = FALSE
	var/distance_to_goal = 0
	var/distance_traveled = 0


/pathfinder/
	var/list/node_search/search_nodes[][]
	var/list/open_list[][]
	var/list/closed_list[][]

	var/level_width = 0
	var/level_height = 0

	var/map


/pathfinder/New(var/desired_width,var/desired_height,var/desired_map)

	level_width = desired_width
	level_height = desired_height
	map = desired_map


	world.log << desired_width
	world.log << desired_height

	initialize_search_nodes()

/pathfinder/proc/heuristic(var/obj/node/point_a,var/obj/node/point_b)
	return abs(point_a.x - point_b.x) + abs(point_a.y - point_b.y)

/pathfinder/proc/reset_search_nodes()
	open_list = new/list()
	closed_list = new/list()

	for(var/x=1,x<=level_width,x++)
		for(var/y=1,y<=level_height,y++)
			var/node_search/NS = search_nodes[x][y]

			if(NS == null)
				continue

			NS.in_open_list = FALSE
			NS.in_closed_list = FALSE

			NS.distance_traveled = INFINITY
			NS.distance_to_goal = INFINITY

/pathfinder/proc/find_best_node()

	var/node_search/current_tile = open_list[1]

	var/smallest_distance_to_goal = INFINITY

	for(var/i=1,i<=length(open_list),i++)
		var/node_search/NS = open_list[i]
		if(NS.distance_to_goal < smallest_distance_to_goal)
			current_tile = open_list[i]
			smallest_distance_to_goal = current_tile.distance_to_goal

	return current_tile

/pathfinder/proc/find_final_path(var/node_search/start_node,var/node_search/end_node)
	closed_list.Add(end_node)

	var/node_search/parent_tile = end_node.parent

	while(parent_tile != start_node)
		closed_list.Add(parent_tile)
		parent_tile = parent_tile.parent

	var/list/Vector2D/final_path = list()

	for(var/i=length(closed_list),i>=1,i--)
		var/node_search/NS = closed_list[i]
		final_path.Add(new/Vector2D(NS.pos.x,NS.pos.y))

	return final_path

/pathfinder/proc/find_path(var/obj/node/start_point,var/obj/node/end_point)

	if(start_point == end_point)
		return null

	reset_search_nodes()

	var/node_search/start_node = search_nodes[start_point.x][start_point.y]
	var/node_search/end_node = search_nodes[end_point.x][end_point.y]

	start_node.in_open_list = TRUE

	start_node.distance_to_goal = heuristic(start_point,end_point)
	start_node.distance_traveled = 0

	open_list.Add(start_node)

	while(length(open_list) > 0)
		var/node_search/current_node = find_best_node()

		if(current_node == null)
			break

		if(current_node == end_node)
			return find_final_path(start_node,end_node)

		for(var/i=1,i<=length(current_node.neighbors),i++)
			var/node_search/neighbor = current_node.neighbors[i]

			if(neighbor == null || !neighbor.is_dense)
				continue

			var/distance_traveled = current_node.distance_traveled + 1

			var/heuristic_dist = heuristic(neighbor.pos,end_node)

			if(!neighbor.in_open_list && !neighbor.in_closed_list)
				neighbor.distance_traveled = distance_traveled
				neighbor.distance_to_goal = distance_traveled + heuristic_dist
				neighbor.parent = current_node
				neighbor.in_open_list = TRUE
				open_list.Add(neighbor)

			else if(neighbor.in_open_list || neighbor.in_closed_list)
				if(neighbor.distance_traveled > distance_traveled)
					neighbor.distance_traveled = distance_traveled
					neighbor.distance_to_goal = distance_traveled + heuristic_dist
					neighbor.parent = current_node

		open_list.Remove(current_node)
		current_node.in_closed_list = TRUE

	return null

/pathfinder/proc/initialize_search_nodes()

	set background = TRUE
	search_nodes = new/list(level_width,level_height)

	world.log << "Length of x: [length(search_nodes)]."
	world.log << "Length of y: [length(search_nodes[1])]."

	for(var/x=1,x<=level_width,x++)
		for(var/y=1,y<=level_height,y++)
			var/node_search/NS = new()
			NS.pos = locate(x,y,map)
			NS.is_dense = NS.pos.density == 0 //TODO: Remake this.

			if(NS.is_dense)
				NS.neighbors = new/list(4)
				search_nodes[x][y] = NS

	for(var/x=1;x<=level_width;x++)
		for(var/y=1,y<=level_height,y++)
			var/node_search/NS = search_nodes[x][y]

			if(NS == null || !NS.is_dense)
				continue

			var/list/obj/node/neighbors = list(
				new /obj/node(locate(x,y-1)),
				new /obj/node(locate(x,y+1)),
				new /obj/node(locate(x-1,y)),
				new /obj/node(locate(x+1,y))
			)

			for(var/i=1,i<=length(neighbors),i++)
				var/obj/node/position = neighbors[i]

				if(position.x <= 0 || position.x > level_width || position.y <= 0 || position.y > level_height)
					continue

				var/node_search/neighbor = search_nodes[position.x][position.y]

				if(neighbor == null || !neighbor.is_dense)
					continue

				NS.neighbors[i] = neighbor

/pathfinder/proc/simplify_vectors(var/list/Vector2D/path)

	world.log << "The simplyify is [length(path)]."


	var/list/Vector2D/new_path = list()
	for(var/i=1 to length(path))
		if(i == length(path))
			continue
		var/Vector2D/v1 = path[i]
		var/Vector2D/v2 = path[i+1]
		if((v2.x == v1.x + 1 && v2.y == v1.y + 1) /*Northeast*/ || (v2.x == v1.x - 1 && v2.y == v1.y + 1) /*Northwest*/ || (v2.x == v1.x - 1 && v2.y == v1.y - 1) /*Southwest*/ || (v2.x == v1.x + 1 && v2.y == v1.y - 1) /*Southeast*/)
			new_path.Add(v2) // Skip the first one and move diagonally to the next one.
			continue

		new_path.Add(v1)

	return new_path