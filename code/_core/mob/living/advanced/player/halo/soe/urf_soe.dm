/mob/living/advanced/player/antagonist/halo/soe
	loadout_to_use = /loadout/urf/soe

/mob/living/advanced/player/antagonist/syndicate/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	return.

/mob/living/advanced/player/antagonist/halo/soe/Finalize()
	. = ..()
	to_chat(span("danger","It's time to show the UNSC how democracy works!"))
	to_chat(span("notice","You are member of elite URF squad, made from Insurrectionists that were ODSTs in the past. You are special forces, used on important bases and operations as spies or defenders."))

/mob/living/advanced/player/antagonist/halo/soe/setup_name()
	. = ..()
	name = "Operative [real_name]"
	return TRUE


/mob/living/advanced/player/antagonist/halo/soe/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE
