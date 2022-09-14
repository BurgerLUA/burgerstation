/mob/living/advanced/npc/nanotrasen
	name = "nanotrasen security personnel"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking NanoTrasen soldier tasked with defending the station and assisting with higher ranking NanoTrasen personnel with missions."
	ai = /ai/advanced/nanotrasen

	dialogue_id = /dialogue/npc/soldier/
	loadout = /loadout/nanotrasen/soldier

	dna = /dna/human

	level = 10

/mob/living/advanced/npc/nanotrasen/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)

/mob/living/advanced/npc/nanotrasen/shaft_miner
	name = "shaft miner"
	desc = "Someone didn't do their job."
	dialogue_id = null
	loadout = /loadout/shaft_miner

	level = 6