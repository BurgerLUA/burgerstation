/obj/item/device/keypad
	name = "keypad"
	desc = "One, One, One...uh....One!"
	desc_extended = "An access keypad. Only works if you know the code."
	icon_state = "keypad_red"
	interactable = TRUE

	var/code = 1337

	value = 10

	var/static/list/obj/hud/button/keypad_buttons = list(
		/obj/hud/button/keypad/bottom,
		/obj/hud/button/keypad/top,
		/obj/hud/button/keypad/close
	)

/obj/item/device/keypad/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("code")

/obj/item/device/keypad/load_item_data_post(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("code")

/obj/item/device/keypad/trigger(mob/caller,atom/source,signal_freq,signal_code)

	if(loc && signal_freq == -1 && signal_code == code)
		loc.trigger(caller,src,-1,-1)

	return TRUE

/obj/item/device/keypad/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(!is_player(caller) || !caller.client)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller
	P.set_device_active(src)

	return TRUE

/obj/item/device/keypad/on_active(mob/living/advanced/player/P)
	show_buttons_to(P)
	return ..()

/obj/item/device/keypad/on_inactive(mob/living/advanced/player/P)
	hide_buttons_from(P)
	return ..()

/obj/item/device/keypad/proc/show_buttons_to(mob/living/advanced/A)
	for(var/v in keypad_buttons)
		var/obj/hud/button/keypad/K = new v
		K.update_owner(A)

/obj/item/device/keypad/proc/hide_buttons_from(mob/living/advanced/A)
	for(var/obj/hud/button/keypad/K in A.buttons)
		K.update_owner(null)