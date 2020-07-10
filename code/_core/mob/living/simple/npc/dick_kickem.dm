/mob/living/simple/npc/dick_kickem
	name = "DICK KICKEM"
	desc = "HE'S HERE TO EAT ASS."
	desc_extended = "What the fuck?"
	icon = 'icons/mob/living/simple/dick_kickem.dmi'
	icon_state = "dick"

	health_base = 2000
	damage_received_multiplier = 0.5

	ai = /ai/dick_kickem/
	class = /class/npc/robust
	damage_type = /damagetype/cqc/sleeping_carp/crashing_wave_kick

	iff_tag = "American"
	loyalty_tag = "American"

	mob_size = MOB_SIZE_BOSS

	armor_base = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 50,
		MAGIC = 25,
		HEAT = 50,
		COLD = 50,
		BOMB = 50,
		BIO = 50,
		RAD = 50,
		HOLY = 25,
		DARK = 100,
		FATIGUE = 50
	)

	status_immune = list(
		STUN = STAGGER,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		DISARM = TRUE,
		FIRE = TRUE
	)