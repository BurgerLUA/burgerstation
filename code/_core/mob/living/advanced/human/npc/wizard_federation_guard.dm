/mob/living/advanced/npc/wizard_federation_guard
	name = "wizard federation guard"
	desc = "Investigating warcrimes since 2068."

	dna = /dna/human

	ai = /ai/advanced/guarding

	level = 16

	loadout = /loadout/wizard_guard

	dna = /dna/human/wizard

/mob/living/advanced/npc/wizard_federation_guard/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

