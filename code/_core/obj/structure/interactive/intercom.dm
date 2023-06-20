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

	plane = PLANE_WALL_ATTACHMENT

/obj/structure/interactive/intercom/PreDestroy()
	QDEL_NULL(stored_radio)
	. = ..()

/obj/structure/interactive/intercom/New(var/desired_loc)
	stored_radio = new stored_radio(src) //Initialized somewhere else. Don't know where, though, honestly.
	stored_radio.set_anchored(TRUE)
	stored_radio.broadcasting = FALSE
	stored_radio.receiving = TRUE
	return ..()

/obj/structure/interactive/intercom/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"intercom_light")
	I.plane = PLANE_LIGHTING_EFFECT
	add_overlay(I)

/obj/structure/interactive/intercom/Initialize()
	try_attach_to()
	setup_dir_offsets()
	return ..()

/obj/structure/interactive/intercom/PostInitialize()
	. = ..()
	update_sprite()

/obj/structure/interactive/intercom/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!stored_radio)
		return ..()

	if(!is_inventory(object))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(caller.attack_flags & CONTROL_MOD_DISARM)
		stored_radio.receiving = !stored_radio.receiving
		caller.to_chat(span("notice","You toggle the intercom receiver [stored_radio.receiving ? "on" : "off"]."))
	else
		stored_radio.broadcasting = !stored_radio.broadcasting
		caller.to_chat(span("notice","You toggle the intercom microphone [stored_radio.broadcasting ? "on" : "off"]."))
		icon_state = stored_radio.broadcasting ? "intercom_speak" : "intercom"

	return TRUE

/obj/structure/interactive/intercom/active/Finalize()
	. = ..()
	stored_radio.broadcasting = TRUE


/obj/structure/interactive/intercom/active/poly/Finalize()
	. = ..()
	stored_radio.broadcasting_range = 3
	stored_radio.listen_range = 3
