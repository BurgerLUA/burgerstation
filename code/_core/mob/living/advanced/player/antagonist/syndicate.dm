/mob/living/advanced/player/antagonist/syndicate
	loadout_to_use = /loadout/syndicate/player_antagonist

/mob/living/advanced/player/antagonist/syndicate/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/groin/syndicate_explosive)
	return.

/mob/living/advanced/player/antagonist/syndicate/Finalize()
	. = ..()
	to_chat(span("danger","You are a highly skilled syndicate agent tasked with sabotaging and destroying the incoming NanoTrasen forces with extreme prejudice."))
	to_chat(span("danger","Work with your team, if any, and purchase your equipment from the donksoft vendor next to where you spawn. Some extra equipment is also lying around the base as well."))
	to_chat(span("danger","<h1>An explosive implant was implanted in your body that triggers when you leave the mission area. Avoid getting captured!</h1>"))

/mob/living/advanced/player/antagonist/syndicate/setup_name()
	. = ..()
	name = "Operative [real_name]"
	return TRUE


/mob/living/advanced/player/antagonist/syndicate/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE
