/mob/living/advanced/npc/goblin
	name = "goblin"
	desc = "Raiding settlements since 4506 BC."

	ai = /ai/advanced
	dna = /dna/goblin

	species = "goblin"

	soul_size = SOUL_SIZE_COMMON

	pixel_z = 1

	iff_tag = "Goblin"
	loyalty_tag = "Goblin"

	loadout = /loadout/goblin

	blood_type = /reagent/blood/goblin

	level = 4

/mob/living/advanced/npc/goblin/Initialize()
	. = ..()
	drops_gold = RAND_PRECISE(0.5,1.25) * level * (1/SSeconomy.credits_per_gold)

/mob/living/advanced/npc/goblin/warrior
	name = "goblin warrior"
	loadout = /loadout/goblin/warrior
	health_base = 300
	stamina_base = 200
	mana_base = 100

	level = 16

/mob/living/advanced/npc/goblin/mage
	name = "goblin mage"
	loadout = /loadout/goblin/mage
	health_base = 200
	stamina_base = 100
	mana_base = 300

	level = 17

/mob/living/advanced/npc/goblin/archer
	name = "goblin archer"
	loadout = /loadout/goblin/archer
	health_base = 200
	stamina_base = 300
	mana_base = 100

	level = 14