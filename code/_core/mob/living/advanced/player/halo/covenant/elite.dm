/mob/living/advanced/player/covenant/elite
	species = "Elite"
	loadout_to_use = /loadout/covenant/elite_player

/mob/living/advanced/player/covenant/elite/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/elite/Finalize()
	. = ..()
	sex = MALE
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are an Elite, that can command other grunts, like kig-yars and minor/major unggoys."))

/mob/living/advanced/player/covenant/elite/setup_name()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_SANG : FIRST_NAME_SANG] [LAST_NAME_SANG]"
	real_name = name
	return TRUE

/mob/living/advanced/player/covenant/elite_shipmaster
	species = "Elite"
	loadout_to_use = /loadout/covenant/elite_shipmaster

/mob/living/advanced/player/covenant/elite_shipmaster/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/elite_shipmaster/Finalize()
	. = ..()
	sex = MALE
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are an Elite Shipmaster, that can command the crew of your ship."))

/mob/living/advanced/player/covenant/elite_shipmaster/setup_name()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_SANG : FIRST_NAME_SANG] [LAST_NAME_SANG]"
	real_name = name
	return TRUE
