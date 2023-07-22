/mob/living/advanced/player/antagonist/halo/soe
	loadout_to_use = /loadout/syndicate/halo/soe

/mob/living/advanced/player/antagonist/halo/soe/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	return.

/mob/living/advanced/player/antagonist/halo/soe/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","It's time to show the UNSC how democracy works!"))
	to_chat(span("notice","You are member of elite URF squad, made from Insurrectionists that were ODSTs in the past. You are special forces, used on important bases and operations as spies or defenders."))
	return .