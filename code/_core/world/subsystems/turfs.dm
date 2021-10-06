SUBSYSTEM_DEF(turfs)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/queued_edges = list()
	var/list/wet_turfs = list()

	cpu_usage_max = 50
	tick_usage_max = 50

	var/list/seeds = list() //id = value

/subsystem/turfs/unclog(var/mob/caller)

	for(var/k in wet_turfs)
		wet_turfs -= k

	for(var/k in queued_edges)
		queued_edges -= k

	broadcast_to_clients(span("danger","Removed all wet turfs and queued edges."))

	return ..()

/subsystem/turfs/Initialize()

	set background = 1 //Needed because it thinks it's doing an infinite loop.

	for(var/i=1,i<=10,i++) //Generate 10 seeds.
		seeds += rand(1,99999)

	var/found_turfs = 0

	for(var/turf/simulated/T in world)
		sleep(-1)
		T.world_spawn = TRUE
		found_turfs++

	log_subsystem(name,"Found [found_turfs] simulated turfs.")

	var/pre_generated = 0
	for(var/turf/unsimulated/generation/G in world)
		sleep(-1)
		G.pre_generate()
		pre_generated++
		if(!(pre_generated % 10000))
			log_subsystem(name,"Pregenerated [pre_generated] unsimulated turfs...")

	log_subsystem(name,"Finished pregenerating [pre_generated] unsimulated turfs.")

	var/full_generated = 0
	for(var/turf/unsimulated/generation/G in world)
		sleep(-1)
		G.generate()
		full_generated++
		if(!(full_generated % 10000))
			log_subsystem(name,"Generated [full_generated] unsimulated turfs...")

	log_subsystem(name,"Finished generating [full_generated] unsimulated turfs.")

	if(ENABLE_GENERATION)
		var/object_generation_count = 0
		var/list/generations = list()
		var/total_markers = 0
		for(var/obj/marker/generation/G in world)
			sleep(-1)
			generations += G
			total_markers++
			if(!(total_markers % 10000))
				log_subsystem(name,"Gathered [total_markers] generation markers...")

		log_subsystem(name,"Finished gathering [total_markers] generation markers.")

		sleep(-1)

		sortMerge(generations, /proc/cmp_generation_priority)

		sleep(-1)

		log_subsystem(name,"Sorted [total_markers] generation markers.")

		for(var/k in generations)
			sleep(-1)
			var/obj/marker/generation/G = k
			G.generate_marker()
			object_generation_count += 1
			if(!(object_generation_count % 10000))
				log_subsystem(name,"Generating [object_generation_count] generation markers...")

		log_subsystem(name,"Finished generating [object_generation_count] generation markers.")

	var/turf_count = 0

	for(var/turf/simulated/S in world)
		sleep(-1)
		INITIALIZE(S)
		turf_count++

	log_subsystem(name,"Initialized [turf_count] turfs.")
	turf_count = 0

	for(var/turf/simulated/S in world)
		sleep(-1)
		FINALIZE(S)
		turf_count++

	log_subsystem(name,"Finalized [turf_count] turfs.")

	log_subsystem(name,"Stored [length(turf_icon_cache)] icons and saved [saved_icons] redundent icons.")

	return ..()

/subsystem/turfs/proc/process_queued_edge(var/turf/T)
	CHECK_TICK(75,FPS_SERVER*3)
	T.update_sprite()
	queued_edges -= T
	return TRUE

/subsystem/turfs/proc/process_wet_turf(var/turf/simulated/T)
	CHECK_TICK(75,FPS_SERVER*3)
	T.wet_level = max(0, T.wet_level - T.wet_level*T.drying_mul - T.drying_add)
	if(T.wet_level <= 0)
		wet_turfs -= T
		T.overlays.Cut()
		T.update_overlays()
	return TRUE

/subsystem/turfs/proc/process_edges()

	for(var/k in queued_edges)
		var/turf/T = k
		if(process_queued_edge(T) == null)
			queued_edges -= k

/subsystem/turfs/proc/process_wet_turfs()

	for(var/k in wet_turfs)
		var/turf/simulated/T = k
		if(process_wet_turf(T) == null)
			wet_turfs -= k


/subsystem/turfs/on_life()

	process_edges()
	process_wet_turfs()


	return TRUE

/proc/queue_update_turf_edges(var/turf/T)

	SSturfs.queued_edges |= T

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T2 = get_step(T,direction)
		SSturfs.queued_edges |= T2

	return TRUE