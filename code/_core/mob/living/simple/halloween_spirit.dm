/mob/living/simple/halloween_spirit
	name = "spirit of halloween"
	desc = "No, not that one."
	desc_extended = "Extremely spooky spirits that only exist to bite your ankles."
	icon = 'icons/mob/living/simple/spooky.dmi'
	icon_state = "red"
	damage_type = /damagetype/melee/sword/claymore/cult
	class = /class/crab

	value = 100

	ai = /ai/

	stun_angle = 0

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 50,
		ARCANE = 25,
		HEAT = 25,
		COLD = 25,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = -50,
		DARK = 200,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

/mob/living/simple/halloween_spirit/blue
	icon_state = "blue"