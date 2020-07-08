/obj/structure/interactive/intercom
	name = "ship intercom"
	desc = "ONE DAY WHILE-"
	desc_extended = "A ship intercom that connects to the ship's common frequency. It can be turned on/off by interacting with it."
	icon = 'icons/obj/structure/radio.dmi'
	icon_state = "intercom"

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"

	var/obj/item/device/radio/stored_radio = /obj/item/device/radio/nanotrasen

	plane = PLANE_WALL_ATTACHMENTS

/obj/structure/interactive/intercom/New(var/desired_loc)
	stored_radio = new(src) //Initialized somewhere else. Don't know where, though, honestly.
	stored_radio.anchored = TRUE
	stored_radio.broadcasting = FALSE
	stored_radio.receiving = TRUE
	return ..()

/obj/structure/interactive/intercom/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"intercom_light")
	I.plane = PLANE_LIGHTING
	I.layer = 99
	add_overlay(I)
	return .

/obj/structure/interactive/intercom/Initialize()
	setup_dir_offsets()
	return ..()

/obj/structure/interactive/intercom/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/intercom/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	INTERACT_CHECK

	if(!stored_radio)
		return ..()

	if(!is_inventory(object))
		return ..()

	stored_radio.broadcasting = !stored_radio.broadcasting
	caller.to_chat(span("notice","You toggle the intercomm microphone [stored_radio.broadcasting ? "on" : "off"]."))
	icon_state = stored_radio.broadcasting ? "intercom_speak" : "intercom"

	return TRUE