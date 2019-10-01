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


	return TRUE