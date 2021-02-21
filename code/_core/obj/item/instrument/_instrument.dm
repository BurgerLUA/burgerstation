/obj/item/instrument/
	name = "piano"
	desc = "Talent not included."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	var/song/current_song = /song/
	var/instrument_type = "piano"

	value = 1000

/obj/item/instrument/New(var/desired_loc)
	. = ..()
	current_song = new current_song(src)
	current_song.instrument_directory = instrument_type
	
/obj/item/instrument/click_self(var/mob/caller,location,control,params)
	if(caller && current_song)
		current_song.interact(caller)
	return TRUE

/obj/item/instrument/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(anchored)

		INTERACT_CHECK

		if(caller && current_song)
			current_song.interact(caller)

		return TRUE

	return ..()

/obj/item/instrument/accordion
	name = "accordion"
	desc = "REMOVE KEBAB."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/accordion.dmi'
	instrument_type = "accordion"
	value = 400

/obj/item/instrument/banjo
	name = "banjo"
	desc = "For fighting off mudcrabs."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/banjo.dmi'
	instrument_type = "banjo"
	value = 400

/obj/item/instrument/bikehorn
	name = "bike horn"
	desc = "HONK."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/bikehorn.dmi'
	instrument_type = "bikehorn"
	value = 300

/obj/item/instrument/eguitar
	name = "electric guitar"
	desc = "If you want panties to get thrown at you, this is an all time classic"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/eguitar.dmi'
	instrument_type = "eguitar"
	value = 600

/obj/item/instrument/glockenspiel
	name = "glockenspiel"
	desc = "D, D, D, A, G#, G, F, D, G, F"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/glockenspiel.dmi'
	instrument_type = "glockenspiel"
	value = 500

/obj/item/instrument/guitar
	name = "guitar"
	desc = "YEEEEEEEEEEEEEEHAAAAAAAAAAAAAWWWWW"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/guitar.dmi'
	instrument_type = "guitar"
	value = 400

/obj/item/instrument/harmonica
	name = "harmonica"
	desc = "The instrument of choice for working class men with the blues."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/harmonica.dmi'
	instrument_type = "harmonica"
	value = 300

/obj/item/instrument/piano
	name = "piano"
	desc = "Talent not included."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/piano.dmi'
	instrument_type = "piano"
	anchored = TRUE
	value = 1000

/obj/item/instrument/recorder
	name = "recorder"
	desc = "This is used mostly to make shitty meme covers of good songs"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/recorder.dmi'
	instrument_type = "recorder"
	value = 300

/obj/item/instrument/saxophone
	name = "saxophone"
	desc = "GUILTY FEET AIN'T GOT NO RYTHM"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/saxophone.dmi'
	instrument_type = "saxophone"
	value = 500

/obj/item/instrument/trombone
	name = "trombone"
	desc = "An instrument fit for a skeleton."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/trombone.dmi'
	instrument_type = "trombone"
	value = 500

/obj/item/instrument/violin
	name = "violin"
	desc = "Not the smallest violin, but it'll do."
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/violin.dmi'
	instrument_type = "violin"
	value = 500

/obj/item/instrument/xylophone
	name = "xylophone"
	desc = "Just like in pre-school!"
	desc_extended = "Songs can be found on the /tg/ Station wiki."
	icon = 'icons/obj/item/instrument/xylophone.dmi'
	instrument_type = "xylophone"
	anchored = TRUE
	value = 300

