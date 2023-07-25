/mob/living/advanced/player/unsc/odst/commander
	loadout_to_use = /loadout/unsc/odst/commander

/mob/living/advanced/player/unsc/odst/commander/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return.

/mob/living/advanced/player/unsc/odst/commander/Finalize()
	. = ..()
	to_chat(span("danger","Dear Humanity; we regret being alien bastards. We regret coming to Earth. And we most definitely regret that the Corps just blew up our raggedy-ass fleet!"))
	to_chat(span("notice","You are a commander of UNSC Stalingrad. Your task is to coordinate the air and ground forces and give orders as the operation progresses."))

/mob/living/advanced/player/unsc/odst/commander/setup_name()
	. = ..()
	name = "Commander [real_name]"
	return TRUE


/mob/living/advanced/player/unsc/odst/commander/species_initialize(var/set_default=FALSE)
	. = ..()
	known_languages[LANGUAGE_CODESPEAK] = TRUE
