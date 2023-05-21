/mob/living/advanced/citizen
	name = "solarian citizen"
	desc = "RIP."

	dna = /dna/human

	soul_size = SOUL_SIZE_COMMON

	ai = /ai/advanced

	level = 4

	health_base = 100
	stamina_base = 100
	mana_base = 100

	loyalty_tag = "Solarian"
	iff_tag = "Solarian"

/mob/living/advanced/citizen/setup_appearance(var/set_default=FALSE)

	. = ..()

	if(gender == FEMALE)
		loadout = /loadout/citizen/female
	else
		loadout = /loadout/citizen/male