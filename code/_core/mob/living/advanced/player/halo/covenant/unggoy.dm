/mob/living/advanced/player/covenant/unggoy
	loadout_to_use = /loadout/covenant/unggoy_minor
	species = "unga"

/mob/living/advanced/player/covenant/unggoy/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/unggoy/Finalize()
	. = ..()
	sex = MALE
	to_chat(span("danger","When in doubt, flee."))
	to_chat(span("notice","Unggoy, also known as Grunts by many individuals, are a species of squat bipedal xeno-arthropodal vertebroid lifeforms from the planet Balaho. In 2142, the Unggoy became the fourth species to be assimilated into the Covenant. Unggoy were primarily used by the Covenant as laborers or�in combat situations�cannon fodder. They are commonly referred to as `Grunts`, mainly because they are considered weak compared to other former Covenant species and because they performed the majority of the labor required by the empire."))
	to_chat(span("notice","You are an Unggoy. The lowest combat unit in entire Covenant forces. You can't command anyone, and mainly your only objective - surviving. Sounds simple, yeah?"))

/mob/living/advanced/player/covenant/unggoy/setup_name()
	. = ..()
	name = "[gender == MALE ? UNGG : UNGG]"
	real_name = name
	return TRUE
