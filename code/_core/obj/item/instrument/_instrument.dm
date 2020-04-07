/obj/item/instrument/
	name = "piano"
	var/song/current_song = /song/
	var/instrument_type = "piano"

/obj/item/instrument/New(var/desired_loc)
	. = ..()
	current_song = new current_song(src)
	current_song.instrument_directory = instrument_type
	return .

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
	icon = 'icons/obj/items/instrument/accordion.dmi'
	instrument_type = "accordion"
	value = 400

/obj/item/instrument/banjo
	name = "banjo"
	icon = 'icons/obj/items/instrument/banjo.dmi'
	instrument_type = "banjo"
	value = 400

/obj/item/instrument/bikehorn
	name = "bike horn"
	icon = 'icons/obj/items/instrument/bikehorn.dmi'
	instrument_type = "bikehorn"
	value = 300

/obj/item/instrument/eguitar
	name = "electric guitar"
	icon = 'icons/obj/items/instrument/eguitar.dmi'
	instrument_type = "eguitar"
	value = 600

/obj/item/instrument/glockenspiel
	name = "glockenspiel"
	icon = 'icons/obj/items/instrument/glockenspiel.dmi'
	instrument_type = "glockenspiel"
	value = 500

/obj/item/instrument/guitar
	name = "guitar"
	icon = 'icons/obj/items/instrument/guitar.dmi'
	instrument_type = "guitar"
	value = 400

/obj/item/instrument/harmonica
	name = "harmonica"
	icon = 'icons/obj/items/instrument/harmonica.dmi'
	instrument_type = "harmonica"
	value = 300

/obj/item/instrument/piano
	name = "piano"
	icon = 'icons/obj/items/instrument/piano.dmi'
	instrument_type = "piano"
	anchored = TRUE
	value = 1000

/obj/item/instrument/recorder
	name = "recorder"
	icon = 'icons/obj/items/instrument/recorder.dmi'
	instrument_type = "recorder"
	value = 300

/obj/item/instrument/saxophone
	name = "saxophone"
	icon = 'icons/obj/items/instrument/saxophone.dmi'
	instrument_type = "saxophone"
	value = 500

/obj/item/instrument/trombone
	name = "trombone"
	icon = 'icons/obj/items/instrument/trombone.dmi'
	instrument_type = "trombone"
	value = 500

/obj/item/instrument/violin
	name = "violin"
	icon = 'icons/obj/items/instrument/violin.dmi'
	instrument_type = "violin"
	value = 500

/obj/item/instrument/xylophone
	name = "xylophone"
	icon = 'icons/obj/items/instrument/xylophone.dmi'
	instrument_type = "xylophone"
	anchored = TRUE
	value = 300

