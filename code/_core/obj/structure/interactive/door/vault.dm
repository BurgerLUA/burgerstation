/obj/structure/interactive/door/vault
	name = "secure vault door"
	desc = "If only I had a drill."
	desc_extended = "A absolute behemoth of a steel door installed with every single anti-bypass feature known to man. There is no way to get through this without the right access."
	icon = 'icons/obj/structure/airlock/vault_door.dmi'
	icon_state = "vault"
	color = "#FFFFFF"
	health = null
	locked = TRUE

/obj/structure/interactive/door/vault/syndicate
	icon = 'icons/obj/structure/airlock/vault_door_dark.dmi'
	desc_extended = "A absolute behemoth of a steel door installed with every single anti-bypass feature known to man. There is no way to get through this without the right code."
	var/obj/item/device/keypad/stored_keypad

/obj/structure/interactive/door/vault/syndicate/PreDestroy()
	SSobj.all_vault_doors -= src
	QDEL_NULL(stored_keypad)
	. = ..()

/obj/structure/interactive/door/vault/syndicate/Generate()
	. = ..()
	stored_keypad = new(src)
	stored_keypad.name = "[src.name] [stored_keypad.name]"
	stored_keypad.code = rand(1000,9999)
	stored_keypad.anchored = TRUE
	INITIALIZE(stored_keypad)
	GENERATE(stored_keypad)
	FINALIZE(stored_keypad)

/obj/structure/interactive/door/vault/syndicate/defer_click_on_object(var/mob/activator,location,control,params)

	if(stored_keypad)
		return stored_keypad

	. = ..()

/obj/structure/interactive/door/vault/syndicate/Finalize()
	. = ..()
	SSobj.all_vault_doors += src


/obj/structure/interactive/door/vault/syndicate/trigger(var/mob/activator,var/atom/source,var/signal_freq,var/signal_code)

	if(door_state == DOOR_STATE_BROKEN)
		return FALSE

	if(door_state == DOOR_STATE_CLOSED)
		if(locked)
			unlock(activator)
			open(activator)
		else
			lock(activator)
	else if(door_state == DOOR_STATE_OPENED)
		close(activator,TRUE)

	return TRUE