/mob/living/advanced/npc/unique/jestmaster
	name = "The Clown"
	desc = "My bottle of lube oughta put a stop to that!"
	species = "human"
	dialogue_id = /dialogue/npc/jestmaster/
	sex = MALE
	gender = MALE

	dna = /dna/human

	anchored = TRUE
	health = null

	level = 50

	loadout = /loadout/clown

/mob/living/advanced/npc/unique/jestmaster/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#FFBAA3")
	change_organ_visual("hair_head", desired_color = "#9E7E6E", desired_icon_state = "hair_a")

/mob/living/advanced/npc/unique/jestmaster/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)