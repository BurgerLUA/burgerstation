/obj/item/chime
	name = "chime"
	desc = "Beep."
	desc_extended = "A special box that emits a sound when triggered by an attached device. By default, comes with a proximity sensor."
	icon = 'icons/obj/item/chime.dmi'
	icon_state = "inventory"

	var/obj/item/device/stored_device = /obj/item/device/proximity

	var/sound_to_play = 'sound/ui/message_double_ping.ogg'

	weight = 3

/obj/item/chime/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("stored_device")
	return .

/obj/item/chime/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("stored_device")
	return .

/obj/item/chime/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(sound_to_play)
		var/turf/T = get_turf(src)
		play(sound_to_play,T)
		create_alert(VIEW_RANGE*0.5,T,last_interacted,ALERT_LEVEL_NOISE)

	return ..()

/obj/item/chime/Generate()
	if(ispath(stored_device))
		stored_device = new stored_device(src)
		INITIALIZE(stored_device)
		GENERATE(stored_device)
		FINALIZE(stored_device)
	return ..()

/obj/item/chime/click_self(var/mob/caller,location,control,params)
	if(stored_device)
		return stored_device.click_self(caller,location,control,params)
	return ..()

/obj/item/chime/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool == FLAG_TOOL_SCREWDRIVER)
			if(stored_device)
				caller.to_chat(span("warning","You remove \the [stored_device.name] from \the [src.name]."))
				stored_device.drop_item(get_turf(src))
				stored_device = null
			else
				caller.to_chat(span("warning","There is nothing to remove from \the [src.name]!"))
			return TRUE
		if(istype(I,/obj/item/device))
			if(stored_device)
				caller.to_chat(span("warning","There is already a [stored_device.name] inside \the [src.name]!"))
				return TRUE
			var/obj/item/device/D = I
			D.drop_item(src)
			stored_device = D
			caller.to_chat(span("notice","You attach \the [D.name] to \the [src.name]."))
			return TRUE

	if(stored_device)
		return stored_device.clicked_on_by_object(caller,object,location,control,params)

	return ..()

/obj/item/chime/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	if(stored_device)
		return stored_device.on_mouse_wheel(caller,delta_x,delta_y,location,control,params)

	return ..()