/mob/living/advanced/player/covenant/elite_minor

	species = "Elite"

/mob/living/advanced/player/covenant/elite_minor/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are a Elite Minor. The lesser sangheili, that can command other grunts, like kig-yars and minor/major unggoys, but also commanded almsot by every other high-ranked crew, like Elite Major, for example."))
	return .

/mob/living/advanced/player/covenant/elite_major

	species = "Elite"

/mob/living/advanced/player/covenant/elite_major/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are a Elite Major. The sangheili, that can command other grunts, like kig-yars, minor/major unggoys and lesser brutes and elites, but also commanded by other high-ranked crew, like Elite Ultra and Brute Captain for example."))
	return .

/mob/living/advanced/player/covenant/elite_shipmaster

	species = "Elite"

/mob/living/advanced/player/covenant/elite_shipmaster/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are a Elite Shipmaster. The sangheili, that can command all forces, like kig-yars, minor/major unggoys and lesser and or higher brutes and elites."))
	return .

/mob/living/advanced/player/covenant/elite_ultra

	species = "Elite"

/mob/living/advanced/player/covenant/elite_ultra/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","On the blood of our fathers, on the blood of our sons, we swore to uphold the Covenant!"))
	to_chat(span("notice","The Sangheili, known to humans as Elites, are a saurian species of strong, proud, and intelligent warriors, as well as skilled combat tacticians. Due to their skill in combat, the Sangheili have formed the military backbone of the Covenant for almost the entirety of its existence."))
	to_chat(span("notice","You are a Elite Ultra. The sangheili, that can command all forces, like kig-yars, minor/major unggoys and lesser and or higher brutes and elites."))
	return .
