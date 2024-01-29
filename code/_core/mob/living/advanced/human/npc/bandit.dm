/mob/living/advanced/npc/bandit
	name = "bandit"
	desc = "Never should've come here."

	dna = /dna/human

	soul_size = SOUL_SIZE_COMMON

	ai = /ai/advanced/bandit

	level = 28

	combat_dialogue = /combat_dialogue/bandit

	health_base = 100
	stamina_base = 100
	mana_base = 100

	loyalty_tag = "Bandit"
	iff_tag = "Bandit"

/mob/living/advanced/npc/bandit/setup_appearance(set_default=FALSE)

	. = ..()

	if(gender == FEMALE)
		loadout = /loadout/bandit/female
	else
		loadout = /loadout/bandit/male