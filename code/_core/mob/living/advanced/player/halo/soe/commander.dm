/mob/living/advanced/player/antagonist/halo/soe/commander
	loadout_to_use = /loadout/syndicate/halo/soe/commander

/mob/living/advanced/player/antagonist/halo/soe/commander/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/syndicate)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/syndicate)
	return.

/mob/living/advanced/player/antagonist/halo/soe/commander/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","You don't believe in god. Only in power of suicide belt"))
	to_chat(span("notice","You are a commander of URF forces. Your task is to coordinate the air and ground forces and give orders as the operation progresses."))
	return .