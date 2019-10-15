/client/proc/on_life()

	if(queued_chat_messages && length(queued_chat_messages) && queued_chat_messages[1])

		var/list/queued_message = queued_chat_messages[1]
		var/text = queued_message["text"]
		var/list/targets = queued_message["output_target_list"]

		for(var/target in targets)
			src << output(text,target)

		queued_chat_messages.Cut(1,2)

	if(mob)

		mob.on_life_client()

		if(is_player(mob))
			if(inactivity > SECONDS_TO_DECISECONDS(660) && inactivity_warning_stage == 2)
				var/mob/living/advanced/player/P = mob
				to_chat(span("danger","You've been inactive for 11 minutes. You will now be logged out of your character."))
				inactivity_warning_stage = 3
				P.make_ghost()
			else if(inactivity > SECONDS_TO_DECISECONDS(600) && inactivity_warning_stage == 1)
				to_chat(span("danger","You've been inactive for 10 minutes. If you are inactive for another minute, your character will be logged out."))
				inactivity_warning_stage = 2
			else if(inactivity > SECONDS_TO_DECISECONDS(300) && inactivity_warning_stage == 0)
				to_chat(span("danger","You've been inactive for 5 minutes. If you are inactive for another 6 minutes, your character will be logged out."))
				inactivity_warning_stage = 1
			else if(inactivity < SECONDS_TO_DECISECONDS(300))
				inactivity_warning_stage = 0


	return TRUE