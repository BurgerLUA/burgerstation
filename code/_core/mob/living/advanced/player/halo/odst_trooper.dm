/mob/living/advanced/player/nt/halo/odst
	loadout_to_use = /loadout/nt/halo/odst

/mob/living/advanced/player/nt/halo/odst/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return.

/mob/living/advanced/player/nt/halo/odst/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","This guy always dies first!"))
	to_chat(span("notice","The Orbital Drop Shock Troopers (ODST) are a special operations capable organization of the UNSC Marine Corps that specialize in orbital-dropped shock infantry and special warfare tactics."))
	return .

/*/mob/living/advanced/player/nt/halo/odst/setup_name()
	. = ..()
	name = "ODST trooper"
	return TRUE*/

/*/mob/living/advanced/player/nt/halo/odst/add_species_languages()
	. = ..()
	known_languages[LANGUAGE_RUSSIAN] = TRUE
	return .*/