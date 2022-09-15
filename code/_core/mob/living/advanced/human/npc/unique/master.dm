/mob/living/advanced/npc/unique/master
	name = "Master-General of the Ordnance"
	desc = "The master of everything."

	sex = MALE
	gender = MALE

	dna = /dna/human

	species = "stand"

	blood_type = /reagent/blood/human/ab_negative

	dialogue_id = /dialogue/npc/master

	health = null

	anchored = TRUE

	level = 100

	loadout = /loadout/master

/mob/living/advanced/npc/unique/master/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#BC9E8F")
	change_organ_visual("hair_head", desired_color = "#E3D5AF", desired_icon_state = "hair_pompadour_s")

/mob/living/advanced/npc/unique/master/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
