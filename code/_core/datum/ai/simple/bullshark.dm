/ai/bullshark

	aggression = 2
	assistance = 1
	retaliate = TRUE


	var/next_talk = 0

/ai/bullshark/handle_attacking()

	if(objective_attack && next_talk <= world.time)
		var/message_to_say = list(
			"Your server is nearing monthly limit!",
			"It's great to see your Discord server using Bullshark to protect its members from unwanted content.",
			"Bullshark's smart features like artifical intelligence, file scanning and link screenshot previews help keep your members safe.",
			"This month you are approaching the free usage limit for your server. Check your dashboard for full details on your usage and to avoid any service interruption that may leave your server vulnerable.",
			"Bullshark is fully configurable from the web dashboard. No commands to remember!",
			"Possible Porn detected. [rand(1,100)]% match.",
			"Possible Gore detected. [rand(1,100)]% match.",
			"Possible Memes detected. [rand(1,100)]% match.",
			"Possible Violence detected. [rand(1,100)]% match."
		)
		owner.do_say(pick(message_to_say),FALSE)

		next_talk = world.time + SECONDS_TO_DECISECONDS(6)

	return ..()