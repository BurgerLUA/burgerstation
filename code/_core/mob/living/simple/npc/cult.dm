/mob/living/simple/npc/cult/
	class = /class/cult

	iff_tag = "Cult"
	loyalty_tag = "Cult"

/mob/living/simple/npc/cult/cultist
	name = "blood cult peon"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "cultist"

	damage_type = "cultist"

	ai = /ai/cultist

	stun_angle = 0

	damage_type = /damagetype/melee/sword/claymore/cult

	health_base = 50

	movement_delay = DECISECONDS_TO_TICKS(3)

	armor_base = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 0,
		ARCANE = 50,
		HEAT = 50,
		COLD = 50,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -50,
		DARK = 200,
		FATIGUE = 0,
		ION = INFINITY
	)

	level_multiplier = 1

/mob/living/simple/npc/cult/cultist/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	return .

/mob/living/simple/npc/cult/construct

/mob/living/simple/npc/cult/construct/post_death()
	. = ..()
	icon_state = "construct_dead"
	return .

/mob/living/simple/npc/cult/construct/behemoth
	name = "blood cult behemoth"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "behemoth"

	damage_type = /damagetype/unarmed/fists/

	ai = /ai/behemoth

	health_base = 300

	movement_delay = DECISECONDS_TO_TICKS(7)

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 100,
		ARCANE = 0,
		HEAT = 100,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = 0
	)

	level_multiplier = 5

/mob/living/simple/npc/cult/construct/artificer
	name = "blood cult artificer"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "artificer"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/artificer

	health_base = 150

	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 0,
		HEAT = 100,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = 0
	)

	level_multiplier = 2

/mob/living/simple/npc/cult/construct/harvester
	name = "blood cult harvester"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "harvester"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/harvester

	health_base = 50

	movement_delay = DECISECONDS_TO_TICKS(1)

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 0,
		HEAT = 100,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = 0
	)

	level_multiplier = 1

/mob/living/simple/npc/cult/construct/chosen
	name = "blood cult chosen"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "chosen"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/chosen

	health_base = 250

	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 0,
		HEAT = 100,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = 0
	)

	level_multiplier = 10

/mob/living/simple/npc/cult/construct/floating
	name = "blood cult construct"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "floating"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/chosen

	health_base = 250

	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 0,
		HEAT = 100,
		COLD = 100,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = -100,
		DARK = 200,
		FATIGUE = INFINITY,
		ION = 0
	)

	level_multiplier = 3