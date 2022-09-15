/mob/living/advanced/npc/unique/goblin_merchant
	name = "goblin merchant"
	desc = "Profitting from raiding settlements since 4506 BC."

	species = "goblin"

	pixel_z = 1

	blood_type = /reagent/blood/goblin

	dialogue_id = /dialogue/npc/goblin_merchant/

	health = null

	anchored = TRUE

	size = SIZE_10

	level = 28

	dna = /dna/goblin

	loadout = /loadout/goblin/merchant

/mob/living/advanced/npc/unique/goblin_merchant/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
