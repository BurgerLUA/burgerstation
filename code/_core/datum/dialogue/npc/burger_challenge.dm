/dialogue/npc/burger_challenge


/dialogue/npc/burger_challenge/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	if(SSgamemode.active_gamemode && SSgamemode.active_gamemode.round_time_next > 0 && istype(SSgamemode.active_gamemode,/gamemode/mission))

		.["hello"] = list(
			"Pssst. Hey. Hey you. Want a #1?",
			"*challenge"
		)

		.["*challenge"] = list(
			"Yeah. A challenge. The cool kids on the street are calling it the '#1', sounds cool. Huh?",
			"*burger challenge"
		)

		.["*burger challenge"] = list(
			"What's the burger challenge, you ask? Well, the challenge is that I STEAL ALL YOUR WORN GEAR, and I TELEPORT you down to the mission area in a COMPLETELY RANDOM loction. Sounds cool, huh? Want to #1?",
			"take the burger challenge"
		)

		.["take the burger challenge"] = list(
			"Last chance to back out!"
		)

	else

		.["hello"] = list(
			"Pssst. Talk to me again when the mission is announced"
		)

/dialogue/npc/burger_challenge/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "take the burger challenge")
		var/menu/M = get_menu(/menu/dialogue/)
		M.close(P)
		var/choice = input(
			P,
			"Are you sure you want to take the Burger Challenge? ALL of your currently worn and held gear will be LOST FOREVER and you will be teleported to a random, potentially unsafe area in the mission area. Proceed?",
			"Last Chance",
			"Cancel",
		) as null|anything in list("Jesus take the wheel!","NO WAY LOL","Cancel")
		if(choice == "Jesus take the wheel!" && P.dialogue_target && P.dialogue_target.type == /mob/living/advanced/npc/unique/burger_challenge && get_dist(P,P.dialogue_target) <= 2)
			var/turf/T = find_safe_turf_for_event(attempts = 10)
			if(!T)
				P.to_chat(span("warning","Something went wrong..."))
				return .
			spawn
				P.force_move(T)
				P.strip_and_delete_items()
				P.to_chat(span("notice","Somehow, you've ended up here, completely naked and without all your items. Good job."))
			return TRUE



