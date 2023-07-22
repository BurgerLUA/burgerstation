/mob/living/advanced/player/covenant/kig_yar
	loadout_to_use = /loadout/nt/halo/covenant/kigyar_player
	species = "Kigyar"

/mob/living/advanced/player/covenant/kig_yar/default_appearance()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/kig_yar/prepare()
	. = ..()
	name = "[gender == MALE ? FIRST_NAME_MALE : FIRST_NAME_FEMALE] [LAST_NAME]"
	sex = MALE
	setup_name()
	to_chat(span("danger","Jackals may be superior marksmen and they're very sneaky, but that doesn't make them excellent snipers — they’re a little too bloodthirsty for that."))
	to_chat(span("notice","The Kig-Yar are an avian/reptilian species which served the Covenant as mercenaries and privateers. There are two distinct subgroups of Kig-Yar, which Humans have termed Jackals and Skirmishers."))
	to_chat(span("notice","You are a Kig-Yar Marksman. Even while you just a mercenary in this war - you're serving to Elites, High-ranked Brutes and also Skirmishers. You also can command almost all of the grunts."))
	return .