/obj/item/radio
	name = "radio"
	desc = "; COMMS DOWN"
	desc_extended = "A compact station bounced radio, for when standard headset-based communication methods fail."
	icon = 'icons/obj/item/radio.dmi'
	icon_state = "inventory"

	var/obj/item/device/radio/stored_radio = /obj/item/device/radio/headset/nanotrasen

	value = 20

	weight = 1

/obj/item/radio/get_examine_list(var/mob/examiner)
	. = ..()
	. += span("notice","ALT+Click to start broadcasting nearby speech.<br>Use the mouse wheel to change frequencies.<br>Use in hands to toggle the signal reciever.")

/obj/item/radio/PreDestroy()
	QDEL_NULL(stored_radio)
	. = ..()

/obj/item/radio/Generate()
	stored_radio = new stored_radio(src)
	INITIALIZE(stored_radio)
	GENERATE(stored_radio)
	FINALIZE(stored_radio)
	return ..()

/obj/item/radio/click_self(var/mob/activator,location,control,params)
	return stored_radio.click_self(activator,location,control,params)

/obj/item/radio/clicked_on_by_object(var/mob/activator as mob,var/atom/object,location,control,params)
	return stored_radio.clicked_on_by_object(activator,object,location,control,params)

/obj/item/radio/mouse_wheel_on_object(var/mob/activator,delta_x,delta_y,location,control,params)
	return stored_radio.mouse_wheel_on_object(activator,delta_x,delta_y,location,control,params)

/obj/item/radio/trigger(var/mob/activator,var/atom/source,var/signal_freq,var/signal_code)
	return stored_radio.trigger(activator,source,signal_freq,signal_code)

/obj/item/radio/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("stored_radio")

/obj/item/radio/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("stored_radio")
