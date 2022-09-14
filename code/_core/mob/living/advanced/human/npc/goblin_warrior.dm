/mob/living/advanced/npc/goblin
	name = "goblin"
	desc = "Raiding settlements since 4506 BC."

	ai = /ai/advanced
	dna = /dna/goblin

	species = "goblin"

	pixel_z = 1

	iff_tag = "Goblin"
	loyalty_tag = "Goblin"

	loadout = /loadout/goblin

	blood_type = /reagent/blood/goblin

	level = 5

/mob/living/advanced/npc/goblin/warrior
	name = "goblin warrior"
	loadout = /loadout/goblin/warrior
	health_base = 300
	stamina_base = 200
	mana_base = 100

	level = 12

/mob/living/advanced/npc/goblin/mage
	name = "goblin mage"
	loadout = /loadout/goblin/mage
	health_base = 200
	stamina_base = 100
	mana_base = 300

	level = 14
