/obj/structure/interactive/crate/secure
	name = "secure crate"
	desc = "No way you're getting in this."
	desc_extended = "A secure crate."
	icon_state = "secure"

	var/locked = TRUE

	value = 500

/obj/structure/interactive/crate/secure/update_overlays()
	. = ..()
	var/image/I = new/image(icon,locked ? "secure_red" : "secure_green")
	add_overlay(I)
	return .


/obj/structure/interactive/crate/secure/open(var/mob/caller)
	if(locked)
		return FALSE
	. = ..()

/obj/structure/interactive/crate/secure/close(var/mob/caller)
	if(locked)
		return FALSE
	. = ..()

/obj/structure/interactive/crate/secure/proc/lock(var/mob/caller)
	locked = TRUE
	caller?.to_chat(span("notice","You lock \the [src.name]."))
	update_sprite()
	return TRUE

/obj/structure/interactive/crate/secure/proc/unlock(var/mob/caller)
	locked = FALSE
	caller?.to_chat(span("notice","You unlock \the [src.name]."))
	update_sprite()
	return TRUE

/obj/structure/interactive/crate/secure/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller.attack_flags & CONTROL_MOD_ALT)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(locked)
			unlock(caller)
		else
			lock(caller)
		return TRUE

	return ..()

/obj/structure/interactive/crate/secure/cargo
	name = "secure cargo crate"
	var/owner_name
	var/credits_required


/obj/structure/interactive/crate/secure/cargo/get_examine_details_list(var/mob/examiner)

	. = ..()

	if(owner_name)
		. += div("warning","This secure crate belongs to [owner_name]. Those who do not have a matching name cannot open it.")

	if(credits_required)
		. += div("warning","This secure crate will charge [credits_required] credits onec unlocked.")

	var/list/contents_to_display = list()
	for(var/k in contents)
		var/atom/movable/M = k
		contents_to_display += M.name

	. += div("notice","It contains: [english_list(contents_to_display)].")

	return .

/obj/structure/interactive/crate/secure/cargo/lock(var/mob/caller)

	if(!owner_name)
		return ..()

	if(!caller)
		return ..()

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		if(lowertext(A.real_name) != lowertext(owner_name))
			caller.to_chat(span("notice","The [src.name] refuses to lock!"))
			return FALSE
	else
		if(lowertext(caller.name) != lowertext(owner_name))
			caller.to_chat(span("notice","The [src.name] refuses to lock!"))
			return FALSE

	return ..()


/obj/structure/interactive/crate/secure/cargo/unlock(var/mob/caller)

	if(!owner_name)
		return ..()

	if(!caller)
		return ..()

	if(!is_player(caller))
		return FALSE

	var/mob/living/advanced/player/A = caller
	if(A.real_name != owner_name)
		src.do_say("Error: Unrecognized user.")
		return FALSE
	if(credits_required && A.currency < credits_required)
		src.do_say("Error: Not enough credits.")
		return FALSE

	. = ..()

	if(. && credits_required)
		A.adjust_currency(-credits_required)
		src.do_say("Transaction complete.")
		credits_required = null

	return .
