/mob/living/advanced/npc/unique/burger_challenge
	name = "mysterious figure"
	desc = "Take the challenge... if you dare."

	level = 30

	loadout = /loadout/hooded_figure

	dialogue_id = /dialogue/npc/burger_challenge




/mob/living/advanced/npc/unique/hooded_figure/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	add_status_effect(IMMORTAL)