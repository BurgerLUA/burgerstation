/mob/living/advanced/player/Topic(href,href_list[],hsrc)

	if(length(href_list))
		if(href_list["take"])
			var/obj/item/I = locate(href_list["take"])
			if(istype(I))
				I.try_strip(src)
		if(href_list["uncuff"])
			var/mob/living/advanced/A = locate(href_list["uncuff"])
			if(istype(A))
				A.try_uncuff(src)

	return ..()

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

	return TRUE