SUBSYSTEM_DEF(chunk)
	name = "Chunk Subsystem"
	desc = "Handles chunk cleaning."
	tick_rate = SECONDS_TO_TICKS(300) //JUST LIKE MINECRAFT
	priority = SS_ORDER_CHUNK

	tick_usage_max = 25

	var/current_z = 0

	var/list/chunks //Z, X, Y

	var/chunk_count_x = 0
	var/chunk_count_y = 0
	var/chunk_count_z = 0

	var/list/failed_chunk_count = list()
	var/list/unclean_chunks = list()

/subsystem/chunk/unclog(var/mob/caller)
	//Honestly there is literally 0 reason as to why this would fail 3 times in as row.
	//I can't wait to be proven wrong.
	. = ..()

/subsystem/chunk/Initialize()

	chunk_count_x = CEILING(world.maxx/CHUNK_SIZE,1)
	chunk_count_y = CEILING(world.maxy/CHUNK_SIZE,1)
	chunk_count_z = world.maxz

	if(!chunk_count_x || !chunk_count_y || !chunk_count_z)
		CRASH("FATAL ERROR: COULD NOT INITIALIZE CHUNKS!")

	chunks = new/list(chunk_count_z,chunk_count_x,chunk_count_y)

	log_subsystem(src.name,"Creating multidimensional chunks list of [chunk_count_z],[chunk_count_x],[chunk_count_y].")

	//Make all the chunks
	var/added_chunks = 0
	for(var/z=1,z<=chunk_count_z,z++) for(var/x=1,x<=chunk_count_x,x++) for(var/y=1,y<=chunk_count_y,y++)
		var/chunk/C = new
		C.x = x
		C.y = y
		C.z = z
		chunks[z][x][y] = C
		added_chunks++

	log_subsystem(src.name,"Added [added_chunks] chunks.")


	//Link adjacent chunks to eachother.
	for(var/z=1,z<=chunk_count_z,z++) for(var/x=1,x<=chunk_count_x,x++) for(var/y=1,y<=chunk_count_y,y++)
		var/chunk/C = CHUNK_XYZ(x,y,z)
		//get adjacents
		for(var/x2=-1,x2<=1,x2++) for(var/y2=-1,y2<=1,y2++)
			if(x2==0 && y2==0)
				continue
			if(x+x2 < 1 || y+y2 < 1 || x+x2 > chunk_count_x || y+y2 > chunk_count_y)
				continue
			C.adjacent_chunks += CHUNK_XYZ(x+x2,y+y2,z)

	//Add existing map nodes to chunks.
	for(var/k in all_map_nodes)
		var/obj/marker/map_node/N = k
		if(!is_turf(N.loc))
			continue
		var/chunk/CH = CHUNK(N.loc)
		CH.nodes += N

	tick_rate = initial(tick_rate) //Set the tick rate based on the amount of z-levels.
	if(world.maxz >= 1)
		tick_rate = CEILING(tick_rate/world.maxz,1)

	return TRUE

/subsystem/chunk/on_life()

	if(current_z == 0)
		//First time initialize. Don't clean.
		current_z++
		return TRUE

	var/benchmark = true_time()
	current_z = (current_z % world.maxz) + 1
	var/process_count = process_entire_z(current_z)
	benchmark = true_time() - benchmark
	log_subsystem(src.name,"Cleaning zlevel [current_z] took [CEILING(benchmark/10,0.1)] seconds and processed [process_count] cleanable atoms.")

	return TRUE

/subsystem/chunk/proc/process_entire_z(var/z)

	. = 0

	if(z <= 0)
		return .

	var/list/chunks_to_process = list()

	for(var/x=1,x<=chunk_count_x,x++) for(var/y=1,y<=chunk_count_y,y++)
		var/chunk/C = chunks[z][x][y]
		chunks_to_process += C

	var/old_chunks = length(chunks_to_process)

	log_subsystem(src.name,"Checking [old_chunks] chunks...")

	for(var/k in chunks_to_process)
		var/chunk/C = k
		if(!C || !C.visited_by_player)
			chunks_to_process -= C
			continue
		if(length(C.players))
			if(length(C.cleanables) >= (CHUNK_SIZE*CHUNK_SIZE)*0.2) //20% concetration
				failed_chunk_count[C] += 1
				if(failed_chunk_count[C] >= 3)
					unclean_chunks += C
			chunks_to_process -= C
			chunks_to_process -= C.adjacent_chunks
		else
			failed_chunk_count -= C
			unclean_chunks -= C

	log_subsystem(src.name,"Filtered out [old_chunks - length(chunks_to_process)] chunks due to player presence or lack of interaction...")

	for(var/k in chunks_to_process)
		var/chunk/C = k
		if(!C)
			continue
		if(length(C.players))
			continue
		for(var/j in C.cleanables)
			var/atom/movable/M = j
			if(!is_turf(M.loc))
				continue
			var/turf/T = M.loc
			var/area/A = T.loc
			var/chunk/C2 = CHUNK(T)
			if(C != C2)
				continue //It was moved.
			if(!A.safe_storage && M.on_chunk_clean())
				. += 1
			CHECK_TICK(tick_usage_max,FPS_SERVER*10)
		for(var/j in C.spawning_markers)
			var/obj/marker/mob_spawn/MS = j
			MS.process()
			CHECK_TICK(tick_usage_max,FPS_SERVER*10)

	for(var/k in unclean_chunks)
		var/chunk/C = k
		if(!C)
			continue

		if(!length(C.nodes))
			continue

		var/enemies_to_send = min(1 + length(C.cleanables)/30,3)
		enemies_to_send = FLOOR(enemies_to_send,1)

		var/max_enemies_to_send = min(enemies_to_send*5,10)

		for(var/j in C.players)
			if(max_enemies_to_send <= 0)
				break
			var/mob/living/P = j
			var/area/A = get_area(P)
			if(A.area_identifier != "Mission")
				continue
			if(P.dead)
				continue
			if(!SShorde.send_squad(P,/mob/living/advanced/npc/beefman,horde_count_override=enemies_to_send,bypass_restrictions=TRUE))
				continue
			max_enemies_to_send -= enemies_to_send
