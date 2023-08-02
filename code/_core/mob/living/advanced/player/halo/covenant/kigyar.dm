/mob/living/advanced/player/covenant/kig_yar
	loadout_to_use = /loadout/covenant/kigyar_player
	species = "Kigyar"

/mob/living/advanced/player/covenant/kig_yar/setup_iff()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/covenant)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/covenant)
	return.

/mob/living/advanced/player/covenant/kig_yar/Finalize()
	. = ..()
	sex = MALE
	to_chat(span("danger","Jackals may be superior marksmen and they're very sneaky, but that doesn't make them excellent snipers � they�re a little too bloodthirsty for that."))
	to_chat(span("notice","The Kig-Yar are an avian/reptilian species which served the Covenant as mercenaries and privateers. There are two distinct subgroups of Kig-Yar, which Humans have termed Jackals and Skirmishers."))
	to_chat(span("notice","You are a Kig-Yar Marksman. Even while you just a mercenary in this war - you're serving to Elites, High-ranked Brutes and also Skirmishers. You also can command almost all of the grunts."))

/mob/living/advanced/player/covenant/kig_yar/setup_name()
	. = ..()
	name = "[gender == MALE ? JACK : JACK]"
	real_name = name
	return TRUE