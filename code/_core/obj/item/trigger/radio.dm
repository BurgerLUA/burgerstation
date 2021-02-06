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

	var/broadcasting_range = 5
	var/listen_range = 0 // Set to 0 to ignore distance.

	listener = TRUE

	value = 20

/obj/item/device/radio/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("frequency")
	return .

/obj/item/device/radio/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("frequency")
	return .

/obj/item/device/radio/click_self(var/mob/caller,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(1)
	broadcasting = !broadcasting
	caller.to_chat(span("notice","You toggle the receiver to <b>[broadcasting ? "always broadcast." : "only broadcast when pressed."]</b>"))
	return TRUE

/obj/item/device/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_inventory(object))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	receiving = !receiving
	caller.to_chat(span("notice","You toggle the speaker <b>[receiving ? "on" : "off"]</b>."))
	return TRUE

/obj/item/device/radio/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)

	INTERACT_CHECK

	var/fixed_delta = delta_y > 0 ? 2 : -2

	var/old_frequency = frequency

	frequency = 1 + FLOOR(frequency + fixed_delta,2)

	if(frequency > frequency_max) frequency = frequency_max
	if(frequency < frequency_min) frequency = frequency_min

	var/frequency_string = frequency_to_name(frequency)
	if(frequency_string == "Unknown")
		frequency_string = null

	var/freq = frequency_string ? " (<b>[frequency_string]</b>)" : ""

	if(old_frequency == frequency)
		caller.to_chat(span("warning","The frequency can't seem to go any [frequency == frequency_min ? "lower" : "higher"]!"))
	else if(spam_fix_time <= world.time)
		caller.to_chat(span("notice","You change \the [src.name]'s frequency to [frequency*0.1] kHz[freq]..."))
	else
		caller.to_chat(span("notice","...[frequency*0.1] kHz[freq]..."))

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
		for(var/k in all_radios)
			var/obj/item/device/radio/S = k
			if(S == src)
				continue
			S.trigger(caller,src,frequency,signal_code)
	else
		if(loc && signal_freq == frequency)
			loc.trigger(caller,src,signal_freq,signal_code)
			return TRUE

/obj/item/device/radio/on_listen(var/atom/speaker,var/datum/source,var/text,var/language_text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)
	if(talk_type == TEXT_RADIO) //Don't listen to other radio signals.
		return FALSE
	if(listen_range > 0 && get_dist(source,src) > listen_range)
		return FALSE
	if(!broadcasting && !(frequency > 0)) //Dumb logic here, but it catches null as well as null (greater,less,equal) 0 is always 0.
		return FALSE
	use_radio(speaker,src,text,language_text,TEXT_RADIO,src.frequency,language,talk_range)
	return ..()


/obj/item/device/radio/nanotrasen
	name = "\improper NanoTrasen Radio"

	frequency_min = RADIO_FREQ_ALPHA - 20
	frequency_max = RADIO_FREQ_SHIP + 20

	value = 15

/obj/item/device/radio/syndicate
	name = "\improper NanoTrasen Radio"

	frequency_min = RADIO_FREQ_SYNDICATE
	frequency_max = RADIO_FREQ_COMMON

	frequency = RADIO_FREQ_SYNDICATE

	value = 100