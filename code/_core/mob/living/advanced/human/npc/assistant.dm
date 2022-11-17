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