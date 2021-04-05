/mob/living/advanced/proc/try_uncuff(var/mob/caller)
	if(!can_uncuff(caller))
		return FALSE
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/uncuff,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_uncuff,caller)
	return TRUE

/mob/living/advanced/proc/uncuff(var/mob/caller)
	caller.visible_message(span("warning","\The [caller.name] removes \the [src.name]'s handcuffs."),span("notice","You remove \the [src.name]'s handcuffs."))
	set_handcuffs(FALSE)
	return TRUE

/mob/living/advanced/proc/can_uncuff(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(src.qdeleting)
		caller.to_chat(span("warning","That doesn't exist!"))
		return FALSE

	if(!handcuffed)
		caller.to_chat(span("warning","They're already free!"))
		return FALSE

	if(caller == src)
		return FALSE

	return TRUE