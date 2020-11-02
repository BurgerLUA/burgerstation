/mob/living/simple/npc/snow_legion
	name = "snow legion"
	icon = 'icons/mob/living/simple/snowlegion.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/venus_human_trap

	health_base = 100

	ai = /ai/

	stun_angle = 0

	value = 100

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -50,
		ARCANE = 100,
		HEAT = -200,
		COLD = INFINITY,
		BOMB = -50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = -50,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = INFINITY
	)

	movement_delay = DECISECONDS_TO_TICKS(4)

	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/snow_legion/post_death()
	. = ..()
	icon_state = "dead"
	return .