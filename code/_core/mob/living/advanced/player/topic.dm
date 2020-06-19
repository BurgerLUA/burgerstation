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
	caller.to_chat(span("notice","You remove \the [src.name]'s handcuffs."))
	set_handcuffs(FALSE)
	return TRUE

/mob/living/advanced/proc/can_uncuff(var/mob/caller)

	if(src.qdeleting)
		caller.to_chat(span("warning","That doesn't exist!"))
		return FALSE

	if(get_dist(src,caller) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(!handcuffed)
		caller.to_chat(span("warning","They're already free!"))
		return FALSE

	return TRUE











/obj/item/proc/try_strip(var/mob/caller)
	if(!can_strip(caller))
		return FALSE
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/strip,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_strip,caller)
	return TRUE

/obj/item/proc/strip(var/mob/caller)

	caller.to_chat(span("notice","You remove \the [src.name]."))

	drop_item(get_turf(src))

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.put_in_hands(src)

	return TRUE

/obj/item/proc/can_strip(var/mob/caller)

	if(src.qdeleting)
		caller.to_chat(span("warning","That doesn't exist!"))
		return FALSE

	if(get_dist(src,caller) > 1)
		caller.to_chat(span("warning","You're too far away!"))
		return FALSE

	if(!istype(loc,/obj/hud/inventory/organs/))
		caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/obj/hud/inventory/I = loc
	if(!is_living(I.owner))
		caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/mob/living/L = I.owner
	if(!L.dead)
		caller.to_chat(span("warning","You can't remove clothing from living people!"))
		return FALSE

	return TRUE