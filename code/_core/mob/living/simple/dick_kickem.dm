/mob/living/simple/dick_kickem
	name = "DICK KICKEM"
	desc = "HE'S HERE TO EAT ASS."
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/dick_kickem.dmi'
	icon_state = "dick"

	health_base = 2500
	stamina_base = 5000
	mana_base = 50

	ai = /ai/dick_kickem/

	damage_type = /damagetype/npc/dick_kickem

	iff_tag = "Meme"
	loyalty_tag = "Meme"

	size = SIZE_BOSS

	armor_base = list(
		BLADE = 40,
		BLUNT = 40,
		PIERCE = 40,
		LASER = 40,
		ARCANE = 40,
		HEAT = 40,
		COLD = 40,
		BOMB = 40,
		BIO = 40,
		RAD = 40,
		HOLY = 40,
		DARK = 40,
		FATIGUE = 40,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE
	)

	blood_type = /reagent/blood/human/a_positive

	soul_size = SOUL_SIZE_UNCOMMON

	level = 40