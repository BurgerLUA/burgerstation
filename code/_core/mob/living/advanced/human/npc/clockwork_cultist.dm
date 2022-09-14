/mob/living/advanced/npc/clockwork_cultist
	name = "clockwork cultist"
	desc = "Hail Ratvar!"
	desc_extended = "A cultist of Ratvar."
	ai = /ai/advanced/clockwork_cult

	dna = /dna/human

	loadout = /loadout/clockwork_cult

	health_base = 100
	mana_base = 100
	stamina_base = 100

	level = 40

/mob/living/advanced/npc/clockwork_cultist/Finalize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/clockwork_cult)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/clockwork_cult)

