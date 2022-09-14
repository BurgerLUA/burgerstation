/mob/living/advanced/npc/unique/hop
	name = "Head of Personnel"
	desc = "All access, please."
	species = "human"
	dialogue_id = /dialogue/npc/hop/
	sex = FEMALE
	gender = FEMALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 42

	loadout = /loadout/hop

/mob/living/advanced/npc/unique/hop/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#B48E7A")
	change_organ_visual("hair_head", desired_color = "#634933", desired_icon_state = "hair_long")

/mob/living/advanced/npc/unique/hop/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
