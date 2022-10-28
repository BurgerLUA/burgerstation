/mob/living/advanced/npc/tax_man
	name = "tax man"
	desc = "Handles your tax."
	desc_extended = "Pay your taxes or suffer the consequences."
	ai = null
	move_mod = 1

	dna = /dna/human

	dialogue_id = /dialogue/npc/taxman/
	anchored = TRUE

	level = 4

	loadout = /loadout/taxman

/mob/living/advanced/npc/tax_man/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)


/mob/living/advanced/npc/tax_man/helper
	name = "tax assistant"
	desc = "Explains things to you."
	desc_extended = "Pay your taxes or suffer the consequences."


/mob/living/advanced/npc/tax_collector
	name = "tax collector"
	desc = "PAY YOUR TAXES."
	desc_extended = "One of the most lethal accountants in the galaxy. Hunts you down and kills you until you pay your taxes."

	ai = /ai/advanced/taxman

	level = 30

	soul_size = SOUL_SIZE_UNCOMMON

	loadout = /loadout/tax_collector

/mob/living/advanced/npc/tax_collector/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/space_cop)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/space_cop)