/gamemode/endless
	name = "Freeroam"
	desc = "No missions right now. Do anything you want."
	hidden = FALSE

	var/last_vote = 0
	var/vote_delay = SECONDS_TO_DECISECONDS(60*60)

/gamemode/endless/New()
	. = ..()
	announce("Central Command",name,desc)
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(300)
	allow_launch = TRUE
	for(var/k in all_fog)
		var/obj/effect/fog_of_war/F = k
		F.remove()
	set_status_display("mission",name)

/gamemode/endless/on_life()

	if(world.time - last_vote >= vote_delay)
		if(world.time >= SECONDS_TO_DECISECONDS(60*60*2))
			world.end(WORLD_END_NANOTRASEN_VICTORY)
		else
			SSvote.create_vote(/vote/continue_round)
		last_vote = world.time

	var/time_left = vote_delay - (world.time - last_vote)
	if(time_left >= 0)
		set_status_display("mission",get_clock_time(FLOOR(DECISECONDS_TO_SECONDS(time_left),1)))

/gamemode/endless/virtual_reality
	name = "VR"
	desc = "Do some virtual reality missions. Or don't."
	hidden = TRUE