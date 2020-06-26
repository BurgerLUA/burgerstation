/mob/living/advanced/player/antagonist/rev
	name = "Slavonic corps LTD lieutenant colonel"
	loadout_to_use = /loadout/rev/player_antagonist

/mob/living/advanced/player/antagonist/rev/prepare()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/groin/syndicate_explosive)
	to_chat(span("danger","You are a highly skilled russian agent tasked with sabotaging and destroying the incoming NanoTrasen forces with extreme prejudice. <h1>An explosive implant was implanted in your head that triggers when you leave the Area of Operations.</h1> Cooperation with local Syndicate operators is advised."))
	return .


/mob/living/advanced/player/antagonist/rev/setup_name()
	name = "Lieutenant Colonel [gender == MALE ? FIRST_NAME_MALE_RUSSIAN : FIRST_NAME_FEMALE_RUSSIAN] [LAST_NAME_RUSSIAN]"
	real_name = name
	return TRUE