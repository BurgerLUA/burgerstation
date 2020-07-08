/obj/item/clothing/ears/headset
	name = "headset"
	desc = "; HELP MAINT!"
	desc_extended = "A headset for communicating with your fellows. Use the mouse wheel to change frequencies, and use the ';' prefix while speaking to talk into it."
	icon = 'icons/obj/item/clothing/ears/headset.dmi'

	var/obj/item/device/radio/stored_radio = /obj/item/device/radio/nanotrasen

/obj/item/clothing/ears/headset/Generate()
	stored_radio = new stored_radio(src)
	INITIALIZE(stored_radio)
	GENERATE(stored_radio)
	return ..()

/obj/item/clothing/ears/headset/click_self(var/mob/caller,location,control,params)
	return stored_radio.click_self(caller,location,control,params)

/obj/item/clothing/ears/headset/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	return stored_radio.clicked_on_by_object(caller,object,location,control,params)

/obj/item/clothing/ears/headset/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)
	return stored_radio.on_mouse_wheel(caller,delta_x,delta_y,location,control,params)

/obj/item/clothing/ears/headset/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	return stored_radio.trigger(caller,source,signal_freq,signal_code)


/obj/item/clothing/ears/headset/save_item_data(var/save_inventory = TRUE)
	. = ..()
	if(stored_radio) .["stored_radio"] = stored_radio.save_item_data(save_inventory)
	return .

/obj/item/clothing/ears/headset/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	if(object_data["stored_radio"]) stored_radio = load_and_create(P,object_data["stored_radio"],src)
	return .