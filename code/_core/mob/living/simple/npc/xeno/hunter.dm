/mob/living/simple/npc/xeno/hunter
	name = "xeno hunter"
	icon = 'icons/mob/living/simple/alien_hunter.dmi'

	health_base = 50

	level_multiplier = 2

	movement_delay = 2

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 75,
		LASER = 0,
		ARCANE = 50,
		HEAT = 25,
		COLD = 100,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 100,
		FATIGUE = 75,
		ION = INFINITY
	)

	can_leap = TRUE

/mob/living/simple/npc/xeno/drone
	name = "xeno drone"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	health_base = 100

	movement_delay = 3

	armor_base = list(
		BLADE = 50,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 0,
		ARCANE = 50,
		HEAT = 25,
		COLD = 100,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 100,
		FATIGUE = 75,
		ION = INFINITY
	)

	can_leap = TRUE

/mob/living/simple/npc/xeno/sentinel
	name = "xeno sentinel"
	icon = 'icons/mob/living/simple/alien_drone.dmi'

	level_multiplier = 4

	health_base = 150

	movement_delay = DECISECONDS_TO_TICKS(AI_TICK)

	armor_base = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 75,
		LASER = 25,
		ARCANE = 50,
		HEAT = 25,
		COLD = 100,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 100,
		FATIGUE = 75,
		ION = INFINITY
	)

	can_spit = TRUE

	movement_delay = 4
