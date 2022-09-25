/gamemode/endless
	name = "Endless"
	desc = "No missions right now. Do anything you want."
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

/gamemode/endless/New()
	. = ..()
	round_time_next = 30


/gamemode/endless/proc/add_objectives()

	var/player_count = length(all_clients)

	log_debug("Current player count: [player_count].")

	//Base Objectives.
	add_objective(/objective/artifact)
	add_objective(/objective/hostage)
	add_objective(/objective/hostage)
	add_objective(/objective/kill_boss)

	if(player_count >= 10)
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


/gamemode/endless/on_continue()

	add_objective(/objective/artifact)
	add_objective(/objective/kill_boss)

	round_time = 0
	round_time_next = 60*30
	stage = 4

	return ..()

/gamemode/endless/on_life()

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
			if(2)
				status_display_text = "PREP"
				round_time_next = 1*60
				announce(
					"Central Command Mission Update",
					"Drop Pod Boarding",
					"All landfall crew are ordered to proceed to the hanger bay and prep for drop pod launch. Drop pods will be allowed to launch in 1 minute.",
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
				status_display_text = "BTTLE"
				round_time_next = 60*60
				add_objectives()
			if(5)
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