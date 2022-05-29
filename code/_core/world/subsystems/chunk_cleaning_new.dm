SUBSYSTEM_DEF(chunk)
	name = "Chunk Subsystem"
	desc = "Handles chunk cleaning."
	tick_rate = SECONDS_TO_TICKS(300) //JUST LIKE MINECRAFT
	priority = SS_ORDER_DELETE

	cpu_usage_max = 25
	tick_usage_max = 25

	var/current_z = 0

	var/list/active_chunks //Z, X, Y

	var/chunk_count_x = 0
	var/chunk_count_y = 0
	var/chunk_count_z = 0


/subsystem/chunk/Initialize()

	chunk_count_x = CEILING(world.maxx/CHUNK_SIZE,1)
	chunk_count_y = CEILING(world.maxy/CHUNK_SIZE,1)
	chunk_count_z = world.maxz

	if(!chunk_count_x || !chunk_count_y || !chunk_count_z)
		//Something went wrong...
		return FALSE

	log_debug("Creating multidimensional active_chunks list of [chunk_count_z],[chunk_count_x],[chunk_count_y].")

	active_chunks = new/list(chunk_count_z,chunk_count_x,chunk_count_y)

	for(var/z=1,z<=chunk_count_z,z++)
		for(var/x=1,x<=chunk_count_x,x++)
			for(var/y=1,y<=chunk_count_y,y++)
				active_chunks[z][x][y] = new /chunk/

	for(var/k in all_map_nodes)
		var/obj/marker/map_node/N = k
		if(!N.loc || !N.loc.z)
			continue
		var/x = CEILING(N.loc.x/CHUNK_SIZE,1)
		var/y = CEILING(N.loc.y/CHUNK_SIZE,1)
		var/z = N.loc.z
		var/chunk/CH = active_chunks[z][x][y]
		CH.nodes += N

	. = ..()

	tick_rate = initial(tick_rate)
	if(world.maxz>=1)
		tick_rate = CEILING(tick_rate/world.maxz,1)

	for(var/mob/living/L in world)
		if(!L.respawn)
			continue
		var/turf/simulated/T = get_turf(L)
		if(!istype(T))
			log_error("Warning: [T] at ([T.x],[T.y],[T.z]) is not a simulated turf and had a mob spawnpoint on it.")
			continue
		var/obj/marker/mob_spawn/M = new(T,L.type,L,L.respawn_time,L.force_spawn)
		M.set_dir(L.random_spawn_dir ? pick(NORTH,EAST,SOUTH,WEST) : L.dir)

/subsystem/chunk/on_life()

	if(current_z == 0)
		//First time initialize. Don't clean.
		current_z++
		return TRUE

	var/benchmark = true_time()
	current_z = (current_z % world.maxz) + 1
	var/process_count = process_entire_z(current_z)
	benchmark = true_time() - benchmark
	log_subsystem(src.name,"Cleaning zlevel [current_z] took [CEILING(benchmark/10,0.1)] seconds and deleted [process_count] mobs/items..")

	return TRUE

/subsystem/chunk/proc/process_entire_z(var/z)

	if(!z)
		return 0

	. = 0

	for(var/x=1,x<=chunk_count_x,x++)
		for(var/y=1,y<=chunk_count_y,y++)
			if(length(active_chunks[z][x][y]))
				continue
			var/list/chunk_turfs = get_chunk_turfs(x,y,z)
			for(var/k in chunk_turfs)
				CHECK_TICK(tick_usage_max,FPS_SERVER*10)
				var/turf/T = k
				var/area/A = T.loc
				if(A.safe_storage)
					continue
				for(var/j in T.contents)
					var/atom/movable/M = j
					if(M.enable_chunk_clean)
						. += M.on_chunk_clean()

/proc/get_chunk_turfs(var/chunk_x,var/chunk_y,var/chunk_z)

	var/min_x = max(1,1 + CHUNK_SIZE * (chunk_x-1))
	var/min_y = max(1,1 + CHUNK_SIZE * (chunk_y-1))

	var/max_x = min(world.maxx,CHUNK_SIZE * chunk_x)
	var/max_y = min(world.maxy,CHUNK_SIZE * chunk_y)

	var/turf/T1 = locate(min_x,min_y,chunk_z)
	var/turf/T2 = locate(max_x,max_y,chunk_z)

	return block(T1,T2)
