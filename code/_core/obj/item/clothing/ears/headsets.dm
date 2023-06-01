/obj/item/clothing/ears/headset
	name = "nanotrasen headset"
	desc = "; HELP MAINT!"
	desc_extended = "A headset for communicating with your fellows. Use the mouse wheel to change frequencies, and use the ';' prefix while speaking to talk into it."
	icon = 'icons/obj/item/clothing/ears/headset.dmi'

	var/obj/item/device/radio/stored_radio = /obj/item/device/radio/headset/nanotrasen

/obj/item/clothing/ears/headset/Finalize()
	if(ispath(stored_radio))
		stored_radio = new stored_radio(src)
		INITIALIZE(stored_radio)
		GENERATE(stored_radio)
		FINALIZE(stored_radio)
	return ..()

/obj/item/clothing/ears/headset/PreDestroy()
	QDEL_NULL(stored_radio)
	. = ..()

/obj/item/clothing/ears/headset/click_self(var/mob/caller,location,control,params)
	return stored_radio.click_self(caller,location,control,params)

/obj/item/clothing/ears/headset/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	return stored_radio.clicked_on_by_object(caller,object,location,control,params)

/obj/item/clothing/ears/headset/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)
	return stored_radio.mouse_wheel_on_object(caller,delta_x,delta_y,location,control,params)

/obj/item/clothing/ears/headset/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	return stored_radio.trigger(caller,source,signal_freq,signal_code)

/obj/item/clothing/ears/headset/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("stored_radio")

/obj/item/clothing/ears/headset/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("stored_radio")

/obj/item/clothing/ears/headset/syndicate
	name = "syndicate headset"
	icon = 'icons/obj/item/clothing/ears/antag_headset.dmi'
	stored_radio = /obj/item/device/radio/headset/syndicate

	contraband = TRUE

/obj/item/clothing/ears/headset/mercenary
	name = "mercenary headset"
	icon = 'icons/obj/item/clothing/ears/antag_headset.dmi'
	stored_radio = /obj/item/device/radio/headset/mercenary

	contraband = TRUE

/obj/item/clothing/ears/headset/revolutionary
	name = "revolutionary headset"
	icon = 'icons/obj/item/clothing/ears/antag_headset.dmi'
	stored_radio = /obj/item/device/radio/headset/revolutionary

	contraband = TRUE

/obj/item/clothing/ears/headset/nanotrasen/medical
	name = "nanotrasen medical headset"
	icon = 'icons/obj/item/clothing/ears/medical_headset.dmi'
	stored_radio = /obj/item/device/radio/headset/nanotrasen/medical

/obj/item/clothing/ears/headset/nanotrasen/cat
	name = "\improper cat ear headset"
	icon = 'icons/obj/item/clothing/hats/cat.dmi'
	desc = "; HELPIES!"
	desc_extended = "This may have been a mistake. Use the mouse wheel to change frequencies, and use the ';' prefix while speaking to talk into it."
	stored_radio = /obj/item/device/radio/headset/nanotrasen

	no_initial_blend = TRUE

	dyeable = TRUE

	polymorphs = list(
		"outer" = "#FFFFFF",
		"inner" = "#FF8888"
	)

	worn_layer = LAYER_MOB_CLOTHING_HELMET + 0.01

	rarity = RARITY_UNCOMMON
