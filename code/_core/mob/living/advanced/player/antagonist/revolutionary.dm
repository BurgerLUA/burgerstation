/mob/living/advanced/player/antagonist/revolutionary
	loadout_to_use = /loadout/rev/player_antagonist

/mob/living/advanced/player/antagonist/revolutionary/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/groin/syndicate_explosive)
	return.

/mob/living/advanced/player/antagonist/revolutionary/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","You are a highly skilled revolutionary tasked with sabotaging and destroying the incoming NanoTrasen forces with extreme prejudice."))
	to_chat(span("danger","Work with your team, if any, and purchase your equipment from the donksoft vendor next to where you spawn. Some extra equipment is also lying around the base as well."))
	to_chat(span("danger","<h1>An explosive implant was implanted in your head that triggers when you leave the Area of Operations. Avoid getting captured if you can.</h1>"))
	return .

/mob/living/advanced/player/antagonist/revolutionary/setup_name()
	. = ..()
	name = "Comrade [real_name]"
	return TRUE

/mob/living/advanced/player/antagonist/revolutionary/add_species_languages()
	. = ..()
	known_languages[LANGUAGE_RUSSIAN] = TRUE
	return .