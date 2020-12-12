

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

	set background = TRUE

	for(var/i=1,i<=10,i++) //Generate 10 seeds.
		seeds += rand(1,99999)

	var/found_turfs = 0
	var/turf_generation_count = 0
	var/object_generation_count = 0

	for(var/turf/simulated/T in world)
		T.world_spawn = TRUE
		found_turfs++

	log_subsystem(name,"Found [found_turfs] simulated turfs.")

	for(var/turf/unsimulated/generation/G in world)
		G.pre_generate()

	for(var/turf/unsimulated/generation/G in world)
		G.generate()
		turf_generation_count++

	log_subsystem(name,"Randomly Generated [turf_generation_count] turfs.")

	for(var/obj/marker/generation/G in world)
		G.generate()
		object_generation_count++

	log_subsystem(name,"Randomly Generated [object_generation_count] random islands.")

	var/turf_count = 0

	for(var/turf/simulated/S in world)
		INITIALIZE(S)
		turf_count++

	log_subsystem(name,"Initialized [turf_count] turfs.")
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


/subsystem/turfs/on_life()

	for(var/k in queued_edges)
		var/turf/T = k
		if(process_queued_edge(T) == null)
			queued_edges -= k

	for(var/k in wet_turfs)
		var/turf/simulated/T = k
		if(process_wet_turf(T) == null)
			wet_turfs -= k

	return TRUE

/proc/queue_update_turf_edges(var/turf/T)

	SSturfs.queued_edges |= T

	for(var/direction in DIRECTIONS_ALL)
		var/turf/T2 = get_step(T,direction)
		SSturfs.queued_edges |= T2

	return TRUE