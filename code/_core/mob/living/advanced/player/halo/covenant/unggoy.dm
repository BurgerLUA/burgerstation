/mob/living/advanced/player/covenant/unggoy_minor
	loadout_to_use = /loadout/nt/halo/covenant/unggoyminor
	species = "unga"

/mob/living/advanced/player/covenant/unggoy_minor/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/unggoy_minor/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","When in doubt, flee."))
	to_chat(span("notice","Unggoy, also known as Grunts by many individuals, are a species of squat bipedal xeno-arthropodal vertebroid lifeforms from the planet Balaho. In 2142, the Unggoy became the fourth species to be assimilated into the Covenant. Unggoy were primarily used by the Covenant as laborers or—in combat situations—cannon fodder. They are commonly referred to as `Grunts`, mainly because they are considered weak compared to other former Covenant species and because they performed the majority of the labor required by the empire."))
	to_chat(span("notice","You are a Unggoy Minor. The lowest combat unit in entire Covenant forces. You can't command anyone, and mainly your only objective - surviving. Sounds simple, yeah?"))
	return .