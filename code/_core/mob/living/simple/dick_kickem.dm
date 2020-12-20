/mob/living/simple/dick_kickem
	name = "DICK KICKEM"
	desc = "HE'S HERE TO EAT ASS."
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/dick_kickem.dmi'
	icon_state = "dick"

	health_base = 2500

	ai = /ai/dick_kickem/
	class = /class/npc/robust
	damage_type = /damagetype/npc/dick_kickem

	iff_tag = "Meme"
	loyalty_tag = "Meme"

	mob_size = MOB_SIZE_BOSS

	armor_base = list(
		BLADE = AP_AXE,
		BLUNT = AP_AXE,
		PIERCE = AP_AXE,
		LASER = AP_AXE,
		ARCANE = AP_AXE,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BOMB = AP_AXE,
		BIO = AP_AXE,
		RAD = AP_AXE,
		HOLY = AP_AXE,
		DARK = AP_AXE,
		FATIGUE = AP_AXE,
		ION = INFINITY,
		PAIN = INFINITY
	)

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		STAMCRIT = STAGGER,
		DISARM = TRUE,
		FIRE = TRUE
	)

	blood_type = /reagent/blood/human/a_positive