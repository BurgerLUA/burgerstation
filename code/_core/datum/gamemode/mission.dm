/gamemode/mission
	name = "Mission"
	desc = "Complete a major mission before the Space Military arrives."
	hidden = FALSE

	var/last_vote = 0
	var/vote_delay = SECONDS_TO_DECISECONDS(60*60)

	round_time_next = 0

	var/stage = 0
	//0 = starting
	//1 = gearing
	//2 = prepping
	//3 = allowed to launch
	//4 = enemies are spawning
	//5 = voting

	var/status_display_text
	var/status_display_time

	var/pvp_start_time = -1
	var/boredom_warning = FALSE

	gamemode_horde_data = /horde_data/syndicate

	var/mob/living/interior_corpse_type
	var/mob/living/exterior_corpse_type

/gamemode/mission/New()
	var/local_benchmark = true_time()
	log_debug("Spawning missions mobs...")
	. = ..()
	spawn_and_set_enemies()
	round_time_next = 30
	var/benchmark_time = DECISECONDS_TO_SECONDS((true_time() - local_benchmark))
	log_debug("Mission mobs took <b>[benchmark_time]</b> seconds to spawn.")

/gamemode/mission/proc/spawn_and_set_enemies()

	set background = TRUE

	if(!gamemode_horde_data)
		return FALSE

	var/horde_data/HD = SShorde.all_horde_data_types[gamemode_horde_data]

	var/list/area_to_mob_type_whitelist = list()

	var/mission_mobs_created = 0
	for(var/k in mission_mob_markers)
		var/obj/marker/M = k
		if(!M.loc)
			qdel(M)
			CHECK_TICK(50,FPS_SERVER*10)
			continue
		var/turf/T = M.loc
		var/area/A = T.loc

		var/chosen_data
		if(area_to_mob_type_whitelist[A.type])
			chosen_data = area_to_mob_type_whitelist[A.type]
		else if(area_to_mob_type_whitelist[A.parent_type])
			chosen_data = area_to_mob_type_whitelist[A.parent_type]
		else
			chosen_data = pickweight(HD.horde_weights)
			area_to_mob_type_whitelist[A.type] = chosen_data

		if(istext(chosen_data))
			chosen_data = pick(HD.horde_squads[chosen_data])

		var/mob/living/L = new chosen_data(T)
		L.dir = pick(DIRECTIONS_CARDINAL)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		mission_mobs_created++
		qdel(M)
		CHECK_TICK(50,FPS_SERVER*10)

	log_debug("Created [mission_mobs_created] mission mobs.")

	var/corpses_created = 0
	if(interior_corpse_type || exterior_corpse_type)
		for(var/k in corpse_markers)
			var/obj/marker/M = k
			if(!M.loc || !is_turf(M.loc))
				qdel(M)
				CHECK_TICK(50,FPS_SERVER*10)
				continue
			var/turf/T = M.loc
			var/area/A = T.loc
			var/mob/living/advanced/L
			if(A.interior && interior_corpse_type)
				L = new interior_corpse_type(T)
			else
				L = new exterior_corpse_type(T)
			INITIALIZE(L)
			GENERATE(L)
			FINALIZE(L)
			if(!L.has_status_effect(ZOMBIE))
				L.death(silent=TRUE)
				L.enable_chunk_clean = FALSE
				L.make_convincing_corpse()
			L.set_dir(pick(NORTH,EAST,SOUTH,WEST))
			corpses_created++
			qdel(M)
			CHECK_TICK(50,FPS_SERVER*10)

	log_debug("Created [corpses_created] mission mobs.")





/gamemode/mission/proc/add_objectives()

	var/player_count = length(all_clients)

	log_debug("Current player count: [player_count].")

	//Base Objectives.
	add_objective(/objective/artifact)
	add_objective(/objective/hostage)
	add_objective(/objective/hostage)
	add_objective(/objective/kill_boss)

	if(player_count >= 10)
		add_objective(/objective/kill_rogue)
		add_objective(/objective/hostage)
		log_debug("Adding player count 10 objectives.")

	if(player_count >= 30)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 30 objectives.")

	if(player_count >= 50)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 50 objectives.")

	if(player_count >= 70)
		add_objective(/objective/kill_boss)
		log_debug("Adding player count 70 objectives.")

	next_objective_update = world.time + 100
	return TRUE


/gamemode/mission/on_continue()

	add_objective(/objective/artifact)
	add_objective(/objective/kill_boss)

	round_time = 0
	round_time_next = 60*30
	stage = 4

	return ..()

/gamemode/mission/proc/announce_lore()

	return TRUE

/gamemode/mission/on_life()

	. = ..()

	if(round_time_next > 0 && round_time >= round_time_next)
		round_time = 0
		stage++
		switch(stage)
			if(1)
				status_display_text = "GEAR"
				round_time_next = 6*60
				announce(
					"Central Command Mission Update",
					"Prepare for Landfall",
					"All landfall crew are ordered to gear up for planetside combat. Estimated time until shuttle functionality: 6 minutes.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_6_minutes_shuttle.ogg'
				)
				CALLBACK("\ref[src]_announce_lore",rand(100,600),src,src::announce_lore()) //10 to 60 seconds.
			if(2)
				status_display_text = "PREP"
				round_time_next = 1*60
				announce(
					"Central Command Mission Update",
					"Drop Pod Boarding",
					"All landfall crew are ordered to proceed to the hanger bay and prep for drop pod launch. Shuttles will be allowed to launch in 1 minute.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_1_minute_shuttle.ogg'
				)
			if(3)
				status_display_text = "RDY"
				round_time_next = 10
				allow_launch = TRUE
				SShorde.enable = TRUE
				SSevents.enable = TRUE
				announce(
					"Central Command Mission Update",
					"Mission is a Go",
					"Shuttles are prepped and ready to depart into the Area of Operations. All crew are cleared to launch.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_0_minutes_shuttle.ogg'
				)
			if(4)
				status_display_text = "WAR"
				round_time_next = 60*60
				add_objectives()
			if(5 to INFINITY)
				status_display_text = "VOTE"
				round_time_next = -1
				SSvote.create_vote(/vote/continue_round)

	var/time_left = round_time_next - round_time
	if(time_left >= 0)
		status_display_time = get_clock_time(FLOOR(time_left,1))
	else
		status_display_time = null


	if(status_display_text && status_display_time)
		set_status_display("mission","[status_display_text ? status_display_text : "HI"]\n[status_display_time ? status_display_time : "THERE"]")