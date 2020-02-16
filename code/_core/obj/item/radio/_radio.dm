var/global/list/obj/item/radio/all_radios = list()

/obj/item/radio/
	name = "radio"
	desc = "Long distance communication. What could possibly go wrong?"
	icon = 'icons/obj/items/radio.dmi'

	var/frequency = RADIO_FREQ_COMMON //The broadcasting frequency of the radio.
	var/list/listening_frequencies = list(
		RADIO_FREQ_COMMON
	)

	var/receiving = TRUE //Whether or not the radio can receive messages.
	var/broadcasting = FALSE //Whether or not the radio can broadcast messages without having to press the button.

	var/frequency_min = RADIO_FREQ_COMMON
	var/frequency_max = RADIO_FREQ_MAX

	var/spam_fix_time = 0

	var/radio_sound = 'sounds/items/radio.ogg'

	material = list(
		"steel" = 10000,
		"iron" = 5000,
		"glass" = 20000
	)

	value = 5

/obj/item/radio/click_self(var/mob/caller,location,control,params)
	broadcasting = !broadcasting
	caller.to_chat(span("notice","You toggle the receiver to <b>[broadcasting ? "always broadcast." : "only broadcast when pressed."]</b>"))
	return TRUE

/obj/item/radio/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if(!is_inventory(object))
		return ..()
	receiving = !receiving
	caller.to_chat(span("notice","You toggle the speaker <b>[receiving ? "on" : "off"]</b>."))
	return TRUE

/obj/item/radio/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = delta_y > 0 ? 1 : -1

	var/old_frequency = frequency

	frequency = Clamp(frequency + fixed_delta*0.2,frequency_min,frequency_max)

	var/frequency_string = frequency_to_name(frequency)
	if(frequency_string == "Unknown")
		frequency_string = null

	var/freq = frequency_string ? " (<b>[frequency_string]</b>)" : ""

	if(old_frequency == frequency)
		caller.to_chat("The frequency can't seem to go any [frequency == frequency_min ? "lower" : "higher"].")
	else if(spam_fix_time <= curtime)
		caller.to_chat("You change \the [src.name]'s frequency to [frequency] kHz[freq]...")
	else
		caller.to_chat("...[frequency] kHz[freq]...")

	spam_fix_time = curtime + 20

	return TRUE

/obj/item/radio/New(var/desired_loc)
	all_radios += src
	return ..()

/obj/item/radio/Destroy()
	all_radios -= src
	return ..()

//Radio Data Format
/*

list(
	"speaker" = mob,
	"message" = text,
	"time" = time as time of day
	"source" = mob or radio
	"frequency" = number of the radio frequency
)
*/

/obj/item/radio/proc/send_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(!data["frequency"])
		data["frequency"] = frequency

	var/speaker_ref = "/ref[data["speaker"]]"

	if(all_unprocessed_radio_data[speaker_ref])
		return FALSE

	all_unprocessed_radio_data[speaker_ref] = data

	var/turf/current_turf = get_turf(src)

	play_sound(radio_sound,all_mobs_with_clients,vector(current_turf.x,current_turf.y,current_turf.z))

	return TRUE

/obj/item/radio/proc/receive_data(var/list/data = list())

	if(!length(data))
		return FALSE

	if(data["frequency"] != frequency && !(data["frequency"] in listening_frequencies))
		return FALSE

	display_message(data["speaker"],src,data["message"],TEXT_RADIO,data["frequency"])

	return TRUE