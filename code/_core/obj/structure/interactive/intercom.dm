/obj/structure/interactive/intercom
	name = "ship intercom"
	desc = "ONE DAY WHILE-"
	desc_extended = "A ship intercom that connects to the ship's common frequency."
	icon = 'icons/obj/structure/radio.dmi'
	icon_state = "intercom"

	var/obj/item/radio/stored_radio = null

/obj/structure/interactive/intercom/New(var/desired_loc)
	stored_radio = new(src)
	stored_radio.anchored = TRUE
	stored_radio.broadcasting = FALSE
	stored_radio.receiving = TRUE
	return ..()

/obj/structure/interactive/intercom/Initialize(var/desired_loc)
	setup_dir_offsets()
	return ..(loc)

/obj/structure/interactive/intercom/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!stored_radio)
		return ..()

	if(!is_inventory(object))
		return ..()

	stored_radio.broadcasting = !stored_radio.broadcasting
	caller.to_chat(span("notice","You toggle the intercomm microphone [stored_radio.broadcasting ? "on" : "off"]."))
	icon_state = stored_radio.broadcasting ? "intercom_speak" : "intercom"

	return TRUE