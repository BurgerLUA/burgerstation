var/global/list/possible_merc_loadouts = list(
	/loadout/mercenary/stealth_suit,
	/loadout/mercenary/olive_drab,





)


/mob/living/advanced/player/antagonist/merc
	loadout_to_use = null //Chosen based on the above list


/mob/living/advanced/player/antagonist/merc/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/groin/syndicate_explosive)
	return.

/mob/living/advanced/player/antagonist/merc/prepare()

	var/codename_first = pick(SStext.first_codenames)
	SStext.first_codenames -= codename_first
	var/codename_last = pick(SStext.last_codenames)
	SStext.last_codenames -= codename_last

	loadout_to_use = pick(possible_merc_loadouts)
	possible_merc_loadouts -= loadout_to_use

	. = ..()

	name = "[codename_first] [codename_last]"

	setup_name()

	to_chat(span("danger","You are a highly skilled revolutionary tasked with sabotaging and destroying the incoming NanoTrasen forces with extreme prejudice."))
	to_chat(span("danger","Work with your team, if any, and purchase your equipment from the donksoft vendor next to where you spawn. Some extra equipment is also lying around the base as well."))
	to_chat(span("danger","<h1>An explosive implant was implanted in your head that triggers when you leave the Area of Operations. Avoid getting captured if you can.</h1>"))
