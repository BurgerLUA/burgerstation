/mob/living/do_say(var/text_to_say, var/should_sanitize = TRUE, var/talk_type_to_use = TEXT_TALK)

	if(dead)
		to_chat(span("warning","You can't talk while you're dead!"))
		return FALSE

	start_typing()

	. = ..()

	end_typing()

	if(.)
		do_type(TALK_TYPE_EXCLAIMATION)

	return .