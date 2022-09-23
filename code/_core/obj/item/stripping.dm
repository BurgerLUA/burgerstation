/obj/item/proc/try_strip(var/mob/caller)
	if(!can_strip(caller,TRUE))
		return FALSE
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/strip,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_strip,caller,TRUE)
	return TRUE

/obj/item/proc/strip(var/mob/caller)

	var/atom/old_loc = src.loc

	if(caller && src.loc && is_advanced(src.loc.loc))
		caller.visible_message(span("notice","\The [caller.name] strips \the [src.name] off of [src.loc.loc]."),span("notice","You strip \the [src.name]."))

	drop_item(get_turf(src))

	if(!src.qdeleting && is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.put_in_hands(src)
		A.on_strip(src,old_loc)

	return TRUE

/obj/item/proc/can_strip(var/mob/caller,var/messages=FALSE)

	INTERACT_CHECK_NO_DELAY(src)

	if(!istype(loc,/obj/hud/inventory/organs/))
		if(messages) caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/obj/hud/inventory/I = loc
	if(I.ultra_persistant)
		if(messages) caller.to_chat(span("warning","You can't remove this!"))
		return FALSE

	if(!is_living(I.owner))
		if(messages) caller.to_chat(span("warning","That's not there anymore!"))
		return FALSE

	var/mob/living/L = I.owner

	INTERACT_CHECK_OTHER(L)

	if(src.anchored)
		if(messages) caller.to_chat(span("warning","\The [I.name] is on \the [L.name] too securely!"))
		return FALSE

	if(is_living(caller))
		var/mob/living/CL = caller
		if(L.ckey_owner != CL.ckey_owner && !allow_hostile_action(CL.loyalty_tag,L))
			return FALSE

	if(!L.dead)
		if(I.worn)
			if(messages) caller.to_chat(span("warning","You can't remove clothing from living people!"))
			return FALSE
		if(!istype(I,/obj/hud/inventory/organs/groin/pocket) && !L.grabbing_hand)
			if(messages) caller.to_chat(span("warning","You need a better grip to steal this!"))
			return FALSE

	return TRUE