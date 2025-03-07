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


/obj/structure/interactive/crate/secure/open(var/mob/activator)
	if(locked)
		return FALSE
	. = ..()

/obj/structure/interactive/crate/secure/close(var/mob/activator)
	if(locked)
		return FALSE
	. = ..()

/obj/structure/interactive/crate/secure/proc/lock(var/mob/activator)
	locked = TRUE
	activator?.to_chat(span("notice","You lock \the [src.name]."))
	update_sprite()
	return TRUE

/obj/structure/interactive/crate/secure/proc/unlock(var/mob/activator)
	locked = FALSE
	activator?.to_chat(span("notice","You unlock \the [src.name]."))
	update_sprite()
	return TRUE

/obj/structure/interactive/crate/secure/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	if(activator.attack_flags & CONTROL_MOD_DISARM)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		if(locked)
			unlock(activator)
		else
			lock(activator)
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
		. += div("warning","This secure crate will charge [credits_required] credits once unlocked.")

	var/list/contents_to_display = list()
	for(var/k in contents)
		var/atom/movable/M = k
		contents_to_display += M.name

	. += div("notice","It contains: [english_list(contents_to_display)].")


/obj/structure/interactive/crate/secure/cargo/lock(var/mob/activator)

	if(!owner_name)
		return ..()

	if(!activator)
		return ..()

	if(is_advanced(activator))
		var/mob/living/advanced/A = activator
		if(lowertext(A.real_name) != lowertext(owner_name))
			activator.to_chat(span("notice","The [src.name] refuses to lock!"))
			return FALSE
	else
		if(lowertext(activator.name) != lowertext(owner_name))
			activator.to_chat(span("notice","The [src.name] refuses to lock!"))
			return FALSE

	return ..()


/obj/structure/interactive/crate/secure/cargo/unlock(var/mob/activator)

	if(!owner_name)
		return ..()

	if(!activator)
		return ..()

	if(!is_player(activator) || !activator.client)
		return FALSE

	var/mob/living/advanced/player/A = activator
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

