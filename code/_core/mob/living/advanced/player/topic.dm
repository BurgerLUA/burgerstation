/mob/living/advanced/player/Topic(href,href_list[],hsrc)

	if(length(href_list) && href_list["take"])
		var/obj/item/I = locate(href_list["take"])
		I.try_strip(src)

	return ..()

/obj/item/proc/try_strip(var/mob/caller)
	if(!can_strip(caller))
		return FALSE
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/strip,src)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_strip,src)
	return TRUE

/obj/item/proc/strip(var/mob/caller)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.put_in_hands(src)

	return TRUE

/obj/item/proc/can_strip(var/mob/caller)

	if(src.qdeleting)
		return FALSE

	if(!istype(loc,/obj/hud/inventory/organs/))
		return FALSE

	if(get_dist(src,caller) > 1)
		return FALSE

	return TRUE