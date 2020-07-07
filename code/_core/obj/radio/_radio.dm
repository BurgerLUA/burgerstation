/obj/radio
	name = "radio"
	desc = "Radio holder. You shouldn't see this."

	var/frequency = RADIO_FREQ_COMMON //The broadcasting frequency of the radio.
	var/list/listening_frequencies = list(
		RADIO_FREQ_COMMON
	)

	var/receiving = TRUE //Whether or not the radio can receive messages.
	var/broadcasting = FALSE //Whether or not the radio can broadcast messages without having to press the button.

	var/frequency_min = RADIO_FREQ_COMMON
	var/frequency_max = RADIO_FREQ_MAX

	var/spam_fix_time = 0

	var/radio_sound = 'sound/items/radio.ogg'

	value = 10


/obj/radio/click_self(var/mob/caller,location,control,params)
	broadcasting = !broadcasting
	caller.to_chat(span("notice","You toggle the receiver to <b>[broadcasting ? "always broadcast." : "only broadcast when pressed."]</b>"))
	return TRUE

/obj/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if(!is_inventory(object))
		return ..()
	receiving = !receiving
	caller.to_chat(span("notice","You toggle the speaker <b>[receiving ? "on" : "off"]</b>."))
	return TRUE


/obj/radio/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = delta_y > 0 ? 1 : -1

	var/old_frequency = frequency

	frequency = clamp(frequency + fixed_delta*0.2,frequency_min,frequency_max)

	var/frequency_string = frequency_to_name(frequency)
	if(frequency_string == "Unknown")
		frequency_string = null

	var/freq = frequency_string ? " (<b>[frequency_string]</b>)" : ""

	if(old_frequency == frequency)
		caller.to_chat("The frequency can't seem to go any [frequency == frequency_min ? "lower" : "higher"].")
	else if(spam_fix_time <= world.time)
		caller.to_chat("You change \the [src.name]'s frequency to [frequency] kHz[freq]...")
	else
		caller.to_chat("...[frequency] kHz[freq]...")

	spam_fix_time = world.time + 20

	return TRUE


/obj/radio/New(var/desired_loc)
	all_radios += src
	return ..()

/obj/radio/Destroy()
	all_radios -= src
	return ..()