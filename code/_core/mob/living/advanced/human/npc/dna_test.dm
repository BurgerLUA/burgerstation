/mob/living/advanced/npc/dna_test

	dna = /dna/human
	ai = /ai/advanced/nanotrasen

	dialogue_id = /dialogue/npc/soldier/

	level = 10

/mob/living/advanced/npc/dna_test/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)