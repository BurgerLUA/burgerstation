/mob/living/advanced/player/unsc/spartan
	loadout_to_use = /loadout/unsc/spartan
	species = "Spartan"

/mob/living/advanced/player/unsc/spartan/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return.

/mob/living/advanced/player/unsc/spartan/Finalize()
	. = ..()
	sex = MALE
	to_chat(span("danger","You're a Spartan II. Show them how the UNSC does it while dying like your peers."))
	to_chat(span("notice","Find your fireteam buddy. Do you really need someone to explain what a S-II is?"))

/mob/living/advanced/player/unsc/spartan/setup_name()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_SPARTAN : FIRST_NAME_SPARTAN] [LAST_NAME_SPARTAN]"
	real_name = name
	return TRUE


/mob/living/advanced/player/unsc/spartan/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE
