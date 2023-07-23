/mob/living/advanced/player/nt/halo/odst/commander


/mob/living/advanced/player/nt/halo/odst/commander/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	setup_name()
	to_chat(span("danger","Dear Humanity; we regret being alien bastards. We regret coming to Earth. And we most definitely regret that the Corps just blew up our raggedy-ass fleet!"))
	to_chat(span("notice","You are a commander of UNSC Stalingrad. Your task is to coordinate the air and ground forces and give orders as the operation progresses."))
	return .