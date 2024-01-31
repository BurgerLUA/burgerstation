SUBSYSTEM_DEF(turf)
	name = "Turfs Subsystem"
	desc = "Initialize Turfs after they are made."
	priority = SS_ORDER_TURFS
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/wet_turfs = list()

	tick_usage_max = 50

	var/list/seeds = list()

	var/list/icon_cache = list()
	var/saved_icons = 0

	//https://www.desmos.com/calculator/u1xlukfjrf
	var/snow_line
	var/snow_num

	var/list/turf_check_directions = DIRECTIONS_ALL

	var/list/turf/simulated/floor/water_shores = list()

	var/obj/water_ground

	var/list/stored_boss_floor_icons

	var/list/image/turf_damage_icons = new/list(5,4)

/subsystem/turf/unclog(mob/caller)
	wet_turfs.Cut()
	. = ..()

/subsystem/turf/Initialize()

	set background = TRUE

	for(var/i=1,i<=5,i++) for(var/d=1,d<=4,d++)
		var/icon/I = new('icons/turf/damage.dmi',"[i]")
		var/turn_direction = (d-1)*90
		if(turn_direction > 0)
			I.Turn(turn_direction)
		turf_damage_icons[i][d] = I

	water_ground = new(null)
	water_ground.name = "water"
	water_ground.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_ALPHA | RESET_COLOR
	water_ground.vis_flags = VIS_INHERIT_ID
	water_ground.icon = 'icons/turf/floor/icons.dmi'
	water_ground.icon_state = "dirt"
	water_ground.plane = PLANE_WATER_FLOOR
	water_ground.layer = -1000
	water_ground.mouse_opacity = 1


	stored_boss_floor_icons = list()
	var/icon/boss_icon = 'icons/turf/special/boss.dmi'
	for(var/i=1,i<=30,i++)
		CHECK_TICK_HARD
		var/icon/I = ICON_INVISIBLE
		if(prob(60))
			if(prob(80))
				var/icon/N = new /icon(boss_icon,get_quad_icon_state(),NORTH)
				I.Blend(N,ICON_OVERLAY)
			if(prob(80))
				var/icon/E = new /icon(boss_icon,get_quad_icon_state(),EAST)
				I.Blend(E,ICON_OVERLAY)
			if(prob(80))
				var/icon/W = new /icon(boss_icon,get_quad_icon_state(),WEST)
				I.Blend(W,ICON_OVERLAY)
			if(prob(80))
				var/icon/S = new /icon(boss_icon,get_quad_icon_state(),SOUTH)
				I.Blend(S,ICON_OVERLAY)
		else
			if(prob(60))
				var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : SOUTH
				dir_to_use = pick(dir_to_use)
				var/icon/S = new /icon(boss_icon,get_solid_icon_state(),dir_to_use)
				I.Blend(S,ICON_OVERLAY)
			else
				var/dir_to_use = prob(10) ? DIRECTIONS_INTERCARDINAL : DIRECTIONS_CARDINAL
				dir_to_use = pick(dir_to_use)
				var/icon/D = new /icon(boss_icon,get_donut_icon_state(),dir_to_use)
				I.Blend(D,ICON_OVERLAY)
				if(prob(80))
					var/icon/T = new /icon(boss_icon,get_timbit_icon_state())
					I.Blend(T,ICON_OVERLAY)
		stored_boss_floor_icons += I


	snow_line = rand(380,440)
	snow_num = 0.6+rand()*0.2

	var/list/type_to_time = list()

	log_subsystem(src.name,"Generating seeds...")
	for(var/i=1,i<=50,i++) //Generate 50 seeds.
		seeds += rand(1,99999)
		CHECK_TICK_HARD

	//First generation pass.
	log_subsystem(src.name,"Pregenerating turfs...")
	for(var/turf/unsimulated/generation/G in world)
		var/benchmark = true_time()
		G.pre_generate()
		benchmark = true_time() - benchmark
		if(benchmark > 0)
			type_to_time[G.type] += benchmark
		CHECK_TICK_HARD

	//Second generation pass.
	log_subsystem(src.name,"Generating turfs...")
	for(var/turf/unsimulated/generation/G in world)
		var/benchmark = true_time()
		G.generate()
		benchmark = true_time() - benchmark
		if(benchmark > 0)
			type_to_time[G.type] += benchmark
		CHECK_TICK_HARD

	if(!CONFIG("ENABLE_INSTALOAD",FALSE))

		var/list/generations_first = list()
		var/list/generations_second = list()
		var/list/generations_third = list()

		log_subsystem(src.name,"Sorting generation markers...")
		for(var/k in all_generation_markers)
			var/obj/marker/generation/G = k
			if(G.priority == 3)
				generations_third += G
			else if(G.priority == 2)
				generations_second += G
			else if(G.priority == 1)
				generations_first += G
			CHECK_TICK_HARD

		log_subsystem(src.name,"Generating [length(generations_first)] first markers...")
		for(var/k in generations_first)
			var/benchmark = true_time()
			var/obj/marker/generation/G = k
			G.generate_marker()
			benchmark = true_time() - benchmark
			if(benchmark > 0)
				type_to_time[G.type] += benchmark
			CHECK_TICK_HARD

		log_subsystem(src.name,"Generating [length(generations_second)] second markers...")
		for(var/k in generations_second)
			var/benchmark = true_time()
			var/obj/marker/generation/G = k
			G.generate_marker()
			benchmark = true_time() - benchmark
			if(benchmark > 0)
				type_to_time[G.type] += benchmark
			CHECK_TICK_HARD

		log_subsystem(src.name,"Generating [length(generations_third)] third markers...")
		for(var/k in generations_third)
			var/benchmark = true_time()
			var/obj/marker/generation/G = k
			G.generate_marker()
			benchmark = true_time() - benchmark
			if(benchmark > 0)
				type_to_time[G.type] += benchmark
			CHECK_TICK_HARD

		/*
		//ROCKGEN
		var/rockgen_benchmark = true_time()
		var/rockgens_checked = 0
		var/list/rockgens_to_replace = list()
		for(var/turf/unsimulated/dynamic_rock_gen/S in world)
			for(var/d in DIRECTIONS_ALL)
				var/turf/simulated/T = get_step(S,d)
				if(!T || !is_simulated(T))
					continue
				if(!T.opacity || !T.density || T.destruction_turf)
					rockgens_to_replace += S
					break
				CHECK_TICK_HARD
			rockgens_checked++
			CHECK_TICK_HARD

		for(var/k in rockgens_to_replace)
			var/turf/simulated/S = k
			new /turf/simulated/wall/rock/brown(S)
			HOOK_ADD("on_destruction","\ref[S]_rock_gen_on_destruction",S,S,S::do_rock_gen())
			CHECK_TICK_HARD

		rockgen_benchmark = true_time() - rockgen_benchmark
		log_subsystem(src.name,"Checked [rockgens_checked] dynamic rock generation turfs and placed [length(rockgens_to_replace)] rock turfs in [DECISECONDS_TO_SECONDS(rockgen_benchmark)] seconds.")
		*/

	log_subsystem(src.name,"Initializing turfs...")
	for(var/turf/simulated/S in world)
		var/benchmark = true_time()
		INITIALIZE(S)
		benchmark = true_time() - benchmark
		if(benchmark > 0)
			type_to_time[S.type] += benchmark
		CHECK_TICK_HARD

	log_subsystem(src.name,"Finalizing turfs...")
	var/turfs_finalized = 0
	for(var/turf/simulated/S in world)
		var/benchmark = true_time()
		FINALIZE(S)
		benchmark = true_time() - benchmark
		if(benchmark > 0)
			type_to_time[S.type] += benchmark
		turfs_finalized++
		CHECK_TICK_HARD

	log_subsystem(src.name,"Finalized [turfs_finalized] simulated turfs.")

	sort_tim(type_to_time, /proc/cmp_numeric_dsc, associative=TRUE)

	var/turf_length = length(type_to_time)
	if(turf_length >= 1)
		var/num_turfs = min(turf_length,10)
		log_debug("[num_turfs] Most Expensive Types:")
		for(var/i=1,i<=num_turfs,i++)
			var/k = type_to_time[i]
			var/v = type_to_time[k]
			log_debug("#[i]: [k], [DECISECONDS_TO_SECONDS(v)] seconds")

	log_subsystem(src.name,"Processing [length(smart_clear_turfs)] smart clear turf markers...")
	var/benchmark = true_time()
	var/total_turfs_processed = 0
	for(var/k in smart_clear_turfs)
		var/obj/marker/smart_clear_turf/M = k
		total_turfs_processed += M.process()
		qdel(M)
		CHECK_TICK_HARD

	benchmark = true_time() - benchmark
	log_subsystem(src.name,"Smart cleared [total_turfs_processed] turfs which took [DECISECONDS_TO_SECONDS(benchmark)] seconds.")

	. = ..()

/subsystem/turf/on_life()

	for(var/k in wet_turfs)
		var/turf/simulated/T = k
		if(!T)
			continue
		var/wet_level_to_remove = T.wet_level*T.drying_mul + T.drying_add
		T.add_wet(-wet_level_to_remove)
		CHECK_TICK(tick_usage_max,FPS_SERVER*3)

	return TRUE



/subsystem/turf/proc/get_donut_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_surrounding[rand(1,4)]"


/subsystem/turf/proc/get_timbit_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_center[rand(1,4)]"

/subsystem/turf/proc/get_solid_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	return "[returning]_slab[rand(1,4)]"

/subsystem/turf/proc/get_quad_icon_state()

	var/returning = ""

	switch(rand(1,6))
		if(1 to 4)
			returning = "pristine"
		if(5)
			returning = "burnt"
		if(6)
			returning = "cracked"

	if(prob(25))
		returning = "[returning]_surrounding_tile[rand(1,2)]"
	else
		returning = "[returning]_tile[rand(1,24)]"

	return returning