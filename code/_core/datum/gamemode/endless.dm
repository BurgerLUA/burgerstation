/gamemode/endless
	name = "Freeroam"
	desc = "No missions right now. Do anything you want."
	hidden = FALSE

	var/last_vote = 0
	var/vote_delay = SECONDS_TO_DECISECONDS(60*60)

	round_time_next = 0

	var/stage = 0

	var/status_display_text
	var/status_display_time

/gamemode/endless/New()
	. = ..()
	round_time_next = 30

/gamemode/endless/proc/allow_pods()
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(60)

/gamemode/endless/proc/allow_shuttle()
	allow_launch = TRUE
	for(var/k in all_fog)
		var/obj/effect/fog_of_war/F = k
		F.remove()

/gamemode/endless/on_continue()
	. = ..()
	add_objective(/objective/artifact)
	add_objective(/objective/kill_boss)

/gamemode/endless/proc/add_objectives()
	add_objective(/objective/artifact)
	add_objective(/objective/hostage)
	add_objective(/objective/kill_boss)
	add_objective(/objective/kill_boss)
	add_objective(/objective/kill_ghost)
	return TRUE

/gamemode/endless/on_life()

	. = ..()

	if(round_time_next != 0 && round_time >= round_time_next)
		round_time = 0
		stage++
		switch(stage)
			if(1)
				status_display_text = "GEAR"
				round_time_next = 6*60
				SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(6*60)
				announce(
					"Central Command Update",
					"Prepare for Landfall",
					"All landfall crew are ordered to gear up for planetside combat. Estimated time until shuttle and drop pod functionality: 8 minutes.",
					ANNOUNCEMENT_STATION,
					'sound/voice/announcement/landfall_crew_8_minutes.ogg'
				)
				add_objectives()
			if(2)
				status_display_text = "PREP"
				allow_pods()
				round_time_next = 2*60
				announce(
					"Central Command Update",
					"Shuttle Boarding",
					"All landfall crew are ordered to proceed to the hanger bay and prep for shuttle launch. Shuttles will be allowed to launch in 2 minutes.",
					ANNOUNCEMENT_STATION,
					'sound/voice/announcement/landfall_crew_2_minutes.ogg'
				)
			if(3)
				status_display_text = "RDY"
				allow_shuttle()
				round_time_next = 0
				announce(
					"Central Command Mission Update",
					"Mission is a Go",
					"Shuttles are prepped and ready to depart into the Area of Operations. All crew are cleared to launch.",
					ANNOUNCEMENT_STATION,
					'sound/voice/announcement/landfall_crew_0_minutes.ogg'
				)
				last_vote = world.time

	if(stage < 3)
		var/time_left = round_time_next - round_time
		status_display_time = get_clock_time(FLOOR(time_left,1))

	if(last_vote)
		if(last_vote && world.time - last_vote >= vote_delay)
			if(world.time >= SECONDS_TO_DECISECONDS(60*60*2))
				world.end(WORLD_END_NANOTRASEN_VICTORY)
			else
				SSvote.create_vote(/vote/continue_round)
			last_vote = world.time

		var/time_left = vote_delay - (world.time - last_vote)
		if(time_left >= 0)
			status_display_text = "VOTE"
			status_display_time = get_clock_time(FLOOR(DECISECONDS_TO_SECONDS(time_left),1))

	if(status_display_text && status_display_time)
		set_status_display("mission","[status_display_text]\n[status_display_time]")