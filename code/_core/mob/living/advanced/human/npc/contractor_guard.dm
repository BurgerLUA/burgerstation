/mob/living/advanced/npc/contractor_guard
	name = "nanotrasen elite guard"
	desc = "The very best assigned to guard this old man."

	dna = /dna/human

	ai = /ai/advanced/guarding

	dialogue_id = null

	loadout = /loadout/nanotrasen/elite

	level = 80

/mob/living/advanced/npc/clockwork_cultist/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
