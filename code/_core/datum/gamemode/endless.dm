/gamemode/endless
	name = "Freeroam"
	desc = "No missions right now. Do anything you want."
	hidden = FALSE

	var/last_vote = 0

/gamemode/endless/New()
	. = ..()
	announce("Central Command","Endless Mode","No missions today. Feel free to do anything you want.")
	SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(300)
	allow_launch = TRUE
	for(var/k in all_fog)
		var/obj/effect/fog_of_war/F = k
		F.remove()
	set_status_display("mission","END LESS")

/gamemode/endless/on_life()

	if(world.time - last_vote >= SECONDS_TO_DECISECONDS(60*60*60))
		SSvote.create_vote(/vote/continue_round)
		last_vote = world.time