/obj/item/proc/try_strip(var/mob/caller)
	if(!can_strip(caller,TRUE))
		return FALSE
	PROGRESS_BAR(caller,src,5,src::strip(),caller)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_strip(),caller,TRUE)
	return TRUE

/obj/item/proc/strip(var/mob/caller)

	var/atom/old_loc = src.loc

	if(caller && src.loc && is_advanced(src.loc.loc))
		caller.visible_message(
			span("notice","\The [caller.name] strips \the [src.name] off of [src.loc.loc]."),
			span("notice","You strip \the [src.name].")
		)

	drop_item(get_turf(src))

	if(!src.qdeleting && caller && is_advanced(caller))
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

	if(!is_living(caller))
		return FALSE

	var/mob/living/L = I.owner
	var/mob/living/CL = caller

	INTERACT_CHECK_OTHER(L)

	if(src.anchored)
		if(messages) caller.to_chat(span("warning","\The [I.name] is on \the [L.name] too securely!"))
		return FALSE

	if(L.ckey_owner == CL.ckey_owner) //Same ckey.
		if(L.loyalty_tag == CL.loyalty_tag) //Prevents joining as NanoTrasen and giving yourself stuff as antag.
			return FALSE
	else
		if(CL.loyalty_tag == "NanoTrasen")
			if(!allow_hostile_action(CL.loyalty_tag,L)) //NanoTrasen can only strip enemies.
				if(messages) caller.to_chat(span("warning","You can't strip allies!"))
				return FALSE
		else
			if(!L.dead) //Others can only strip when dead.
				if(messages) caller.to_chat(span("warning","You can't strip people who aren't dead!"))
				return FALSE
			if(L.loyalty_tag == "NanoTrasen")
				if(messages) caller.to_chat(span("warning","You refuse to subject yourself to poor-quality NanoTrasen goods!"))
				return FALSE

	if(L.horizontal) //Can strip someone if they're horizontal.
		return TRUE

	if(is_advanced(L))
		var/mob/living/advanced/A = L
		if(A.handcuffed) //Can strip someone if they're handcuffed.
			return TRUE

	if(!I.worn && L.dir & get_dir(CL,I)) //Allow removing of non-worn items from behind (pickpocketing).
		return TRUE

	if(messages) caller.to_chat(span("warning","\The [L.name] is not in a position to be stripped!"))

	return FALSE