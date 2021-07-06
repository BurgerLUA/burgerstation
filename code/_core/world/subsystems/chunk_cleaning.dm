#define CHUNK_SIZE (VIEW_RANGE*2) //In tiles.

SUBSYSTEM_DEF(chunkclean)
	name = "Chunkclean Subsystem"
	desc = "Handles chunk cleaning."
	tick_rate = SECONDS_TO_TICKS(120)
	priority = SS_ORDER_DELETE

	cpu_usage_max = 25
	tick_usage_max = 25

	var/current_z = 0


/subsystem/chunkclean/on_life()

	if(current_z == 0)
		//First time initialize.
		current_z++
		return TRUE

	var/benchmark = world.time
	current_z = (current_z % world.maxz) + 1
	var/process_count = process_entire_z(current_z)
	benchmark = world.time - benchmark
	log_subsystem(src.name,"Cleaning zlevel [current_z] took [CEILING(benchmark/10,0.1)] seconds and deleted [process_count] mobs/items..")

	return TRUE

/subsystem/chunkclean/proc/process_entire_z(var/z)

	if(!z)
		return 0

	var/chunk_count_x = CEILING(world.maxx/CHUNK_SIZE,1)
	var/chunk_count_y = CEILING(world.maxy/CHUNK_SIZE,1)

	var/list/chunk_data = get_chunk_data(TRUE)

	. = 0
	for(var/x=1,x<=chunk_count_x,x++)
		for(var/y=1,y<=chunk_count_y,y++)
			sleep(-1)
			if(chunk_data["[x],[y],[z]"])
				continue
			var/list/chunk_turfs = get_chunk(x,y,z)
			for(var/k in chunk_turfs)
				var/turf/T = k
				for(var/j in T.contents)
					var/atom/movable/M = j
					if(istype(M,/mob/living/))
						var/mob/living/L = M
						if(L.dead && !L.ckey_last)
							qdel(L)
							. += 1
					else if(istype(M,/obj/item/))
						var/obj/item/I = M
						if(I.last_interacted && !istype(I.last_interacted,/mob/living/advanced/player/))
							qdel(I)
							. += 1

/proc/get_chunk_data(var/adjacent=FALSE)

	. = list()

	for(var/k in all_players)
		sleep(-1)
		var/mob/living/advanced/player/P = k
		var/turf/T = get_turf(P)
		if(!T)
			continue
		var/x = CEILING(T.x/CHUNK_SIZE,1)
		var/y = CEILING(T.x/CHUNK_SIZE,1)
		.["[x],[y],[T.z]"] = TRUE
		if(adjacent)
			.["[x-1],[y-1],[T.z]"] = TRUE
			.["[x-1],[y+1],[T.z]"] = TRUE
			.["[x+1],[y-1],[T.z]"] = TRUE
			.["[x+1],[y+1],[T.z]"] = TRUE

/proc/get_chunk(var/chunk_x,var/chunk_y,var/chunk_z)

	var/min_x = max(1,1 + CHUNK_SIZE * (chunk_x-1))
	var/min_y = max(1,1 + CHUNK_SIZE * (chunk_y-1))

	var/max_x = min(world.maxx,CHUNK_SIZE * chunk_x)
	var/max_y = min(world.maxy,CHUNK_SIZE * chunk_y)

	var/turf/T1 = locate(min_x,min_y,chunk_z)
	var/turf/T2 = locate(max_x,max_y,chunk_z)

	return block(T1,T2)
