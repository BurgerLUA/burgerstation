/obj/item/proc/try_strip(var/mob/caller)
	if(!can_strip(caller))
		return FALSE
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/strip,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_strip,caller)
	return TRUE

/obj/item/proc/strip(var/mob/caller)

	drop_item(get_turf(src))

	if(caller && src.loc && is_advanced(src.loc.loc))
		caller.visible_message(span("notice","\The [caller.name] strips \the [src.name] off of [src.loc.loc]."),span("notice","You strip \the [src.name]."))

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.put_in_hands(src)

	return TRUE

/obj/item/proc/can_strip(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(!istype(loc,/obj/hud/inventory/organs/))
		caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/obj/hud/inventory/I = loc
	if(!is_living(I.owner))
		caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/mob/living/L = I.owner

	INTERACT_CHECK_OTHER(L)

	if(!L.dead)
		caller.to_chat(span("warning","You can't remove clothing from living people!"))
		return FALSE

	return TRUE