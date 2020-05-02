/obj/item/radio
	name = "radio"
	desc = "It's a radio"
	icon = 'icons/obj/items/radio.dmi'
	icon_state = "inventory"

	var/obj/item/device/radio/stored_radio = /obj/item/device/radio/nanotrasen

/obj/item/radio/on_spawn()
	stored_radio = new stored_radio(src)
	INITIALIZE(stored_radio)
	SPAWN(stored_radio)
	return ..()

/obj/item/radio/click_self(var/mob/caller,location,control,params)
	return stored_radio.click_self(caller,location,control,params)

/obj/item/radio/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	return stored_radio.clicked_on_by_object(caller,object,location,control,params)

/obj/item/radio/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)
	return stored_radio.on_mouse_wheel(caller,delta_x,delta_y,location,control,params)

/obj/item/radio/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	return stored_radio.trigger(caller,source,signal_freq,signal_code)