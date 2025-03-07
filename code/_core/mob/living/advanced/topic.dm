/mob/living/advanced/Topic(href,href_list[],hsrc)

	if(length(href_list))
		if(href_list["uncuff"])
			var/mob/living/advanced/A = locate(href_list["uncuff"])
			if(istype(A))
				A.try_uncuff(src)

	. = ..()

/mob/living/advanced/proc/try_uncuff(var/mob/activator)
	if(!can_uncuff(activator))
		return FALSE
	PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(3),src::uncuff(),activator)
	PROGRESS_BAR_CONDITIONS(activator,src,src::can_uncuff(),activator)
	return TRUE

/mob/living/advanced/proc/uncuff(var/mob/activator)
	activator.visible_message(span("warning","\The [activator.name] removes \the [src.name]'s handcuffs."),span("notice","You remove \the [src.name]'s handcuffs."))
	set_handcuffs(FALSE)
	return TRUE

/mob/living/advanced/proc/can_uncuff(var/mob/activator)

	INTERACT_CHECK_NO_DELAY(src)

	if(src.qdeleting)
		activator.to_chat(span("warning","That doesn't exist!"))
		return FALSE

	if(!handcuffed)
		activator.to_chat(span("warning","They're already free!"))
		return FALSE

	if(activator == src)
		activator.to_chat(span("warning","Try resisting to remove the handcuffs!"))
		return FALSE

	return TRUE