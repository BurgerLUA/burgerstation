/mob/living/advanced/npc/unique/burger_challenge
	name = "mysterious figure"
	desc = "Take the challenge... if you dare."

	level = 30

	loadout = /loadout/hooded_figure

	dialogue_id = /dialogue/npc/burger_challenge

	anchored = 2




/mob/living/advanced/npc/unique/burger_challenge/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	add_status_effect(IMMORTAL)