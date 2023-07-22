/mob/living/advanced/player/nt/halo/spartan
	loadout_to_use = /loadout/halo/spartan
	species = "Spartan"

/mob/living/advanced/player/nt/halo/spartan/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return.

/mob/living/advanced/player/nt/halo/spartan/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_SPARTAN : FIRST_NAME_SPARTAN] [LAST_NAME_SPARTAN]"
	sex = MALE
	setup_name()
	to_chat(span("danger","You're a Spartan II. Show them how the UNSC does it while dying like your peers."))
	to_chat(span("notice","Find your fireteam buddy. Do you really need someone to explain what a S-II is?"))
	return .
