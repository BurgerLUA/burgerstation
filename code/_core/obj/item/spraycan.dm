/obj/item/spraycan
	name = "spray can"
	desc = "gang shit"
	desc_extended = "For delinquent vandals, artists and gang takeovers alike. Make sure the nozzle is pointed the right way before use."
	icon_state = "spraycan"
	icon = 'icons/obj/item/spraycan.dmi'

	var/spray_color = COLOR_RED

	var/cap_on = TRUE

	var/icon/desired_spray
	var/spray_owner //ckey

	var/obj/effect/cleanable/spray/existing_spray

	value = 3000
	value_burgerbux = 10

	rarity = RARITY_RARE

/obj/item/spraycan/get_examine_list(mob/examiner)
	. = ..()
	if(cap_on == TRUE)
		. += span("notice","Use to select a decal to spray.<br>Click with an empty hand to take off the cap.")
	else
		. += span("notice","Use to select a decal to spray.<br>Click with an empty hand to put the cap back on.")

/obj/item/spraycan/PreDestroy()
	QDEL_NULL(desired_spray)
	QDEL_NULL(existing_spray)
	. = ..()

/obj/item/spraycan/Finalize()
	. = ..()
	update_sprite()

/obj/item/spraycan/click_self(mob/caller,location,control,params)

	if(!caller || !caller.client)
		return TRUE

	var/client/C = caller.client

	if(C.icon_request_details)
		C.icon_request_details.Cut()

	C.icon_request_details = list(
		"proc" = nameof(src::on_upload_spray()),
		"proc_src" = src,
		"width_limit" = 16,
		"height_limit" = 16
	)

	C.upload_icon()

	return TRUE

/obj/item/spraycan/proc/on_upload_spray(client/caller,icon/desired_icon)

	if(!caller || !caller.mob || get_dist(caller.mob,src) > 1)
		return FALSE

	if(desired_spray)
		qdel(desired_spray)

	desired_spray = desired_icon
	spray_owner = caller.ckey

	caller.to_chat(span("notice","Spray successfully set!"))

	return TRUE

/obj/item/spraycan/click_on_object(mob/caller,atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/turf/T = get_turf(object)

	if(T)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		if(cap_on)
			caller.to_chat(span("warning","The cap is on!"))
			return TRUE
		if(!desired_spray)
			caller.to_chat(span("warning","No spray selected."))
			return TRUE
		if(existing_spray && !existing_spray.qdeleting)
			qdel(existing_spray)
		var/obj/effect/cleanable/spray/C = new(T)
		C.icon = desired_spray
		C.name = "\"art\" - by [caller.ckey]"
		play_sound('sound/effects/spray.ogg',T)
		existing_spray = C

	return TRUE

	. = ..()

/obj/item/spraycan/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_DELAY(10)
		toggle_cap(caller)
		return TRUE

	. = ..()


/obj/item/spraycan/proc/toggle_cap(mob/caller)
	cap_on = !cap_on
	update_sprite()
	caller.to_chat(span("notice","You [cap_on ? "add" : "remove"] \the [src.name]'s cap."))
	return TRUE

/obj/item/spraycan/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(cap_on) icon_state = "[icon_state]_cap"

/obj/item/spraycan/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]_colors")
	I.color = spray_color
	add_overlay(I)