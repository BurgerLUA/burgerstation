/mob/living/advanced/player/unsc/odst
	loadout_to_use = /loadout/unsc/odst

/mob/living/advanced/player/unsc/odst/commander/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return.

/mob/living/advanced/player/unsc/odst/Finalize()
	. = ..()
	to_chat(span("danger","This guy always dies first!"))
	to_chat(span("notice","The Orbital Drop Shock Troopers (ODST) are a special operations capable organization of the UNSC Marine Corps that specialize in orbital-dropped shock infantry and special warfare tactics."))

/mob/living/advanced/player/unsc/odst/setup_name()
	. = ..()
	name = "ODST [real_name]"
	return TRUE


/mob/living/advanced/player/unsc/odst/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE
