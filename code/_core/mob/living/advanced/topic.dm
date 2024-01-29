/mob/living/advanced/Topic(href,href_list[],hsrc)

	if(length(href_list))
		if(href_list["uncuff"])
			var/mob/living/advanced/A = locate(href_list["uncuff"])
			if(istype(A))
				A.try_uncuff(src)

	. = ..()

/mob/living/advanced/proc/try_uncuff(mob/caller)
	if(!can_uncuff(caller))
		return FALSE
	PROGRESS_BAR(caller,src,3 SECONDS,src::uncuff(),caller)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_uncuff(),caller)
	return TRUE

/mob/living/advanced/proc/uncuff(mob/caller)
	caller.visible_message(span("warning","\The [caller.name] removes \the [src.name]'s handcuffs."),span("notice","You remove \the [src.name]'s handcuffs."))
	set_handcuffs(FALSE)
	return TRUE

/mob/living/advanced/proc/can_uncuff(mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(src.qdeleting)
		caller.to_chat(span("warning","That doesn't exist!"))
		return FALSE

	if(!handcuffed)
		caller.to_chat(span("warning","They're already free!"))
		return FALSE

	if(caller == src)
		caller.to_chat(span("warning","Try resisting to remove the handcuffs!"))
		return FALSE

	return TRUE
