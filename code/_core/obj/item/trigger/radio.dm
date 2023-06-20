/obj/item/device/radio/
	name = "radio"
	desc = "Long distance communication. What could possibly go wrong?"
	desc_extended = "A handheld radio."
	icon = 'icons/obj/item/radio_transmitter.dmi'
	icon_state = "inventory"

	var/frequency = RADIO_FREQ_COMMON //The broadcasting frequency of the radio.
	var/list/listening_frequencies = list() // The frequencies this radio is allowed to talk on. The above frequency is included.

	var/receiving = TRUE //Whether or not the radio can receive messages.
	var/broadcasting = FALSE //Whether or not the radio can broadcast messages without having to press the button.

	var/frequency_min = RADIO_FREQ_ALPHA
	var/frequency_max = RADIO_FREQ_MAX

	var/spam_fix_time = 0

	var/radio_sound = 'sound/items/radio.ogg'

	var/broadcasting_range = 5 //Range in tiles of which to broadcast sounds.
	var/listen_range = VIEW_RANGE //Range in tiles of which to recieve sounds. Set to 0 to ignore.

	listener = TRUE //This should always be true.

	value = 20

/obj/item/device/radio/Generate()
	. = ..()
	listening_frequencies = list(
		"[frequency]" = TRUE
	)

/obj/item/device/radio/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("frequency")
	SAVELIST("listening_frequencies")

/obj/item/device/radio/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("frequency")
	LOADLIST("listening_frequencies")

/obj/item/device/radio/click_self(var/mob/caller,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(1)

	if(caller.attack_flags & CONTROL_MOD_GRAB)

		var/list/possible_settings = list()

		for(var/k in listening_frequencies)
			var/frequency_string = frequency_to_name(frequency)
			if(frequency_string == "Unknown")
				frequency_string = k
			var/active = listening_frequencies[k] ? TRUE : FALSE
			possible_settings["[active ? "Remove" : "Add"] [frequency_string]"] = k

		possible_settings["Add..."] = "Add..."
		possible_settings["Cancel"] = "Cancel"

		var/chosen_setting = input("What would you like to do?","Radio Settings","Cancel") as null|anything in possible_settings
		if(chosen_setting == "Add...")
			var/desired_frequency = input("What frequency do you wish to add?","Add Frequency","[RADIO_FREQ_COMMON]") as null|text
			if(!desired_frequency)
				return TRUE
			desired_frequency = text2num(desired_frequency)
			if(!desired_frequency || desired_frequency <= 0)
				caller.to_chat(span("warning","Invalid frequency!"))
				return TRUE
			if(MODULUS(desired_frequency,1)) //Entered a correct frequency, however it needs to be multiplied to fit the current system.
				desired_frequency *= 10
			desired_frequency = round(desired_frequency,2) + 1
			if(desired_frequency > frequency_max)
				caller.to_chat(span("warning","Input frequency ([desired_frequency]) is too high for this radio's maximum frequency ([frequency_max])!"))
				return TRUE
			if(desired_frequency < frequency_min)
				caller.to_chat(span("warning","Input frequency ([desired_frequency]) is too low for this radio's minimum frequency ([frequency_min])!"))
				return TRUE

		else if(chosen_setting == "Cancel")
			return TRUE
		else
			//We have an existing number. Toggle it.
			listening_frequencies[chosen_setting[chosen_setting]] = !listening_frequencies[chosen_setting[chosen_setting]]
			caller.to_chat(span("notice","The frequency [chosen_setting[chosen_setting]]([frequency_to_name(chosen_setting[chosen_setting])]) was [listening_frequencies[chosen_setting[chosen_setting]] ? "added to" : "removed from"] \the [src.name]'s listening frequencies."))
		return TRUE

	if(caller.attack_flags & CONTROL_MOD_DISARM)
		broadcasting = !broadcasting
		caller.to_chat(span("notice","You toggle the microphone to <b>[broadcasting ? "always broadcast." : "only broadcast when pressed."]</b>"))
		return TRUE


	receiving = !receiving
	caller.to_chat(span("notice","You toggle the signal reciever <b>[receiving ? "on" : "off"]</b>."))
	return TRUE

/obj/item/device/radio/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)

	INTERACT_CHECK

	var/fixed_delta = clamp(delta_y,-1,1)*2

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

/obj/item/device/radio/Finalize()
	. = ..()
	SSradio.all_radios += src

/obj/item/device/radio/PreDestroy()
	SSradio.all_radios -= src
	. = ..()

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
		for(var/k in SSradio.all_radios)
			var/obj/item/device/radio/S = k
			if(S == src)
				continue
			S.trigger(caller,src,frequency,signal_code)
	else //Recieved
		if(loc && signal_freq == frequency)
			loc.trigger(caller,src,signal_freq,signal_code)
			return TRUE

/obj/item/device/radio/on_listen(var/atom/speaker,var/datum/source,var/text,var/raw_text,var/language_text,var/talk_type,var/frequency, var/language = LANGUAGE_BASIC,var/talk_range=TALK_RANGE)
	if(talk_type == TEXT_RADIO) //Don't listen to other radio signals. This prevents spam.
		return FALSE
	if(listen_range > 0 && get_dist(source,src) > listen_range)
		return FALSE
	if(!broadcasting && !(frequency > 0)) //Dumb logic here, but it catches null as well as null (greater,less,equal) 0 is always 0.
		return FALSE
	if(frequency > 0 && (frequency < frequency_min || frequency > frequency_max))
		return FALSE
	use_radio(speaker,src,text,raw_text,language_text,talk_type,src.frequency,language,talk_range)
	. = ..()

/obj/item/device/radio/nanotrasen
	name = "\improper NanoTrasen station radio"

	frequency_min = RADIO_FREQ_ALPHA - 20
	frequency_max = RADIO_FREQ_SHIP + 20

	value = 15

/obj/item/device/radio/headset
	name = "headset radio"
	broadcasting_range = 1
	listen_range = 2

/obj/item/device/radio/headset/nanotrasen
	name = "\improper NanoTrasen headset radio"

	frequency_min = RADIO_FREQ_ALPHA - 20
	frequency_max = RADIO_FREQ_SHIP + 20

	value = 15

/obj/item/device/radio/headset/nanotrasen/medical
	name = "\improper NanoTrasen medical headset radio"

	frequency_min = RADIO_FREQ_ALPHA - 20
	frequency_max = RADIO_FREQ_SHIP + 20

	value = 15

/obj/item/device/radio/headset/nanotrasen/medical/Generate()
	. = ..()
	listening_frequencies["[RADIO_FREQ_MEDICAL]"] = TRUE


/obj/item/device/radio/headset/mercenary
	name = "\improper Mercenary headset radio"

	frequency_min = RADIO_FREQ_MERCENARY_MIN
	frequency_max = RADIO_FREQ_COMMON

	contraband = TRUE

	value = 300

/obj/item/device/radio/headset/mercenary/Generate()
	. = ..()
	frequency = SSradio.radio_merc
	listening_frequencies = list(
		"[RADIO_FREQ_COMMON]" = TRUE,
		"[frequency]" = TRUE
	)

/obj/item/device/radio/headset/syndicate
	name = "\improper Syndicate headset radio"

	frequency_min = RADIO_FREQ_SYNDICATE_MIN
	frequency_max = RADIO_FREQ_COMMON

	contraband = TRUE

	value = 300

/obj/item/device/radio/headset/syndicate/Generate()
	. = ..()
	frequency = SSradio.radio_syn
	listening_frequencies = list(
		"[RADIO_FREQ_COMMON]" = TRUE,
		"[frequency]" = TRUE
	)

/obj/item/device/radio/headset/revolutionary
	name = "\improper Revolutionary headset radio"

	frequency_min = RADIO_FREQ_REVOLUTIONARY_MIN
	frequency_max = RADIO_FREQ_COMMON

	contraband = TRUE

	value = 300

/obj/item/device/radio/headset/revolutionary/Generate()
	. = ..()
	frequency = SSradio.radio_rev
	listening_frequencies = list(
		"[RADIO_FREQ_COMMON]" = TRUE,
		"[frequency]" = TRUE
	)