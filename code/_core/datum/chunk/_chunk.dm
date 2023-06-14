/chunk/
	var/list/players = list() //List of current players.
	var/list/ai = list() //List of current AI.
	var/list/nodes = list() //List of pathing nodes.
	var/list/cleanables = list() //List of cleanable
	var/list/adjacent_chunks = list() //List of neighboring chunks
	var/list/spawning_markers = list()
	var/list/plants = list()

	var/x = 0
	var/y = 0
	var/z = 0

	var/visited_by_player = FALSE