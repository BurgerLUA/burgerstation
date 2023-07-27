/mob/living/advanced/player/urf/soe/commander
	loadout_to_use = /loadout/urf/soe/commander

/mob/living/advanced/player/urf/soe/commander/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	return.

/mob/living/advanced/player/urf/soe/commander/Finalize()
	. = ..()
	to_chat(span("notice","You are a commander of URF forces. Your task is to coordinate the air and ground forces and give orders as the operation progresses."))

/mob/living/advanced/player/urf/soe/commander/setup_name()
	. = ..()
	name = "Commander [real_name]"
	return TRUE


/mob/living/advanced/player/urf/soe/commander/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE