var/global/obj/item/device/signaller/all_signalers = list()

/obj/item/device/signaller
	name = "signaller"
	icon_state = "signaller"

	var/frequency_current = RADIO_FREQ_MIN
	var/frequency_min = RADIO_FREQ_MIN
	var/frequency_max = RADIO_FREQ_MAX

	var/signal_current = 20
	var/signal_min = 1
	var/signal_max = 50

	var/spam_fix_time = 0

	var/mode = FALSE

/obj/item/device/signaller/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("frequency")
	SAVEVAR("signal_current")
	return .

/obj/item/device/signaller/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("frequency")
	LOADVAR("signal_current")
	return .

/obj/item/device/signaller/door
	frequency_current = RADIO_FREQ_DOOR
	signal_current = 1

/obj/item/device/signaller/New(var/desired_loc)
	all_signalers += src
	return ..()

/obj/item/device/signaller/Destroy()
	all_signalers -= src
	return ..()

/obj/item/device/signaller/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE) //The src attacks the victim, with the blamed taking responsibility
	trigger(attacker,src,-1,-1)
	return TRUE

/obj/item/device/signaller/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(signal_freq == -1 && signal_code == -1)
		for(var/obj/item/device/signaller/S in all_signalers)
			if(S == src)
				continue
			S.trigger(caller,src,frequency_current,signal_current)
		return TRUE

	if(loc && signal_freq == frequency_current && signal_code == signal_current)
		loc.trigger(caller,src,-1,-1)
		return TRUE

	return TRUE

/obj/item/device/signaller/click_self(var/mob/caller)
	mode = !mode
	caller.to_chat("You change the mode to [mode ? "frequency" : "signal"].")
	spam_fix_time = 0
	return TRUE

/obj/item/device/signaller/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = delta_y ? 1 : -1

	if(mode)
		var/old_frequency = frequency_current
		frequency_current = clamp(frequency_current + 0.2*fixed_delta,frequency_min,frequency_max)
		if(old_frequency == frequency_current)
			caller.to_chat(span("notice","\The [src.name]'s frequency can't seem to go any [frequency_current == frequency_min ? "lower" : "higher"]."))
		else if(spam_fix_time <= world.time)
			caller.to_chat(span("notice","You change \the [src.name]'s frequency to [frequency_current] kHz..."))
		else
			caller.to_chat(span("notice","...[frequency_current] kHz..."))
	else
		var/old_signal = signal_current
		signal_current = clamp(signal_current + 1*fixed_delta,signal_min,signal_max)
		if(old_signal == signal_current)
			caller.to_chat(span("notice","\The [src.name]'s signal can't seem to go any [signal_current == signal_min ? "lower" : "higher"]."))
		else if(spam_fix_time <= world.time)
			caller.to_chat(span("notice","You change \the [src.name]'s signal to [signal_current]..."))
		else
			caller.to_chat(span("notice","...[signal_current]..."))

	spam_fix_time = world.time + 20

	return TRUE