/mob/living/advanced/npc/nanotrasen
	name = "\improper NanoTrasen security personnel"
	desc = "A security team that actually follows orders!"
	desc_extended = "A low-ranking NanoTrasen soldier tasked with defending the station and assisting with higher ranking NanoTrasen personnel with missions."
	ai = /ai/advanced/nanotrasen

	dialogue_id = /dialogue/npc/soldier/
	loadout = /loadout/nanotrasen/soldier

	dna = /dna/human

	level = 10



/mob/living/advanced/npc/rogue_assistant
	name = "rogue assistant"
	desc = "Help, maint!"
	ai = /ai/advanced/syndicate

	sex = MALE
	gender = MALE

	dna = /dna/human

	loadout = /loadout/rogue_assistant

	level = 80

/mob/living/advanced/npc/rogue_assistant/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/revolutionary)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/revolutionary)