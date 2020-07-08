var/global/list/obj/item/device/radio/all_radios = list()

/obj/item/device/radio/
	name = "radio"
	desc = "Long distance communication. What could possibly go wrong?"
	desc_extended = "A handheld radio."
	icon = 'icons/obj/item/radio_transmitter.dmi'
	icon_state = "inventory"

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

	var/broadcasting_range = VIEW_RANGE

	value = 5

/obj/item/device/radio/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("frequency")
	return .

/obj/item/device/radio/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("frequency")
	return .

/obj/item/device/radio/click_self(var/mob/caller,location,control,params)
	broadcasting = !broadcasting
	caller.to_chat(span("notice","You toggle the receiver to <b>[broadcasting ? "always broadcast." : "only broadcast when pressed."]</b>"))
	return TRUE

/obj/item/device/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if(!is_inventory(object))
		return ..()
	receiving = !receiving
	caller.to_chat(span("notice","You toggle the speaker <b>[receiving ? "on" : "off"]</b>."))
	return TRUE

/obj/item/device/radio/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

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

/obj/item/device/radio/New(var/desired_loc)
	all_radios += src
	return ..()

/obj/item/device/radio/Destroy()
	all_radios -= src
	return ..()

//Radio Data Format
/*

list(
	"speaker" = atom or text,
	"message" = text,
	"time" = time as time of day
	"source" = mob or radio
	"frequency" = number of the radio frequency
)
*/

/obj/item/device/radio/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(signal_freq == -1) //Sent
		for(var/obj/item/device/radio/S in all_radios)
			if(S == src)
				continue
			S.trigger(caller,src,frequency,signal_code)
	else
		if(loc && signal_freq == frequency)
			loc.trigger(caller,src,signal_freq,signal_code)
			return TRUE


/obj/item/device/radio/proc/send_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(!data["frequency"])
		data["frequency"] = frequency

	var/speaker_ref = is_atom(data["speaker"]) ? "/ref[data["speaker"]]" : null

	if(speaker_ref && all_unprocessed_radio_data[speaker_ref])
		return FALSE

	all_unprocessed_radio_data[speaker_ref] = data

	play(radio_sound,src)

	return TRUE

/obj/item/device/radio/proc/receive_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(data["frequency"] != frequency && !(data["frequency"] in listening_frequencies))
		return FALSE

	var/turf/T = get_turf(src)
	for(var/mob/M in range(broadcasting_range,T))
		if(!M.client)
			continue
		CHECK_TICK
		M.to_chat_language(data["message"],CHAT_TYPE_RADIO,data["language"],data["message_language"])

	return TRUE


/obj/item/device/radio/nanotrasen
	name = "\improper NanoTrasen Radio"

	frequency_min = RADIO_FREQ_ALPHA - 2
	frequency_max = RADIO_FREQ_SHIP + 2

	value = 15