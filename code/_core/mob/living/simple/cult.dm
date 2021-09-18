/mob/living/simple/cult/


	iff_tag = "Cult"
	loyalty_tag = "Cult"

	size = SIZE_HUMAN

	blood_type = /reagent/blood/unholy
	blood_volume = BLOOD_VOLUME_DEFAULT

	soul_size = SOUL_SIZE_COMMON

	level = 10

/mob/living/simple/cult/cultist
	name = "blood cult peon"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "cultist"

	ai = /ai/cultist

	stun_angle = 0

	damage_type = /damagetype/melee/sword/claymore/cult

	health_base = 100
	stamina_base = 50
	mana_base = 50

	movement_delay = DECISECONDS_TO_TICKS(3)

	armor_base = list(
		BLADE = 20,
		BLUNT = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		COLD = 20,
		HOLY = -60,
		DARK = 60,
		FATIGUE = 20,
		ION = INFINITY,
		PAIN = 20
	)

	level = 18


/mob/living/simple/cult/cultist/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"

/mob/living/simple/cult/construct
	stun_angle = 0

	size = SIZE_LARGE

	blood_type = /reagent/blood/unholy
	blood_volume = 1000

	has_footsteps = FALSE

/mob/living/simple/cult/construct/post_death()
	. = ..()
	icon_state = "construct_dead"

/mob/living/simple/cult/construct/behemoth
	name = "blood cult behemoth"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "behemoth"

	damage_type = /damagetype/unarmed/fists/

	ai = /ai/behemoth

	health_base = 200
	stamina_base = 200
	mana_base = 50

	movement_delay = DECISECONDS_TO_TICKS(7)

	armor_base = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 20,
		LASER = -20,
		ARCANE = -10,
		HEAT = 60,
		COLD = 60,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		ION = 0,
		PAIN = INFINITY
	)

	level = 36



/mob/living/simple/cult/construct/artificer
	name = "blood cult artificer"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "artificer"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/artificer

	health_base = 100
	stamina_base = 50
	mana_base = 200

	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 60,
		BLUNT = 60,
		PIERCE = 20,
		LASER = -20,
		ARCANE = -10,
		HEAT = 60,
		COLD = 60,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level = 16



/mob/living/simple/cult/construct/harvester
	name = "blood cult harvester"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "harvester"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/harvester

	health_base = 50
	stamina_base = 100
	mana_base = 50

	movement_delay = DECISECONDS_TO_TICKS(1)

	armor_base = list(
		BLADE = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		HEAT = 80,
		COLD = 80,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level = 24



/mob/living/simple/cult/construct/chosen
	name = "blood cult chosen"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "chosen"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/chosen

	health_base = 150
	stamina_base = 100
	mana_base = 100


	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 20,
		PIERCE = 20,
		LASER = -40,
		ARCANE = 20,
		HEAT = 80,
		COLD = 80,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level = 28



/mob/living/simple/cult/construct/floating
	name = "blood cult construct"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "floating"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai/chosen

	health_base = 150
	stamina_base = 100
	mana_base = 100

	movement_delay = DECISECONDS_TO_TICKS(2)

	armor_base = list(
		BLADE = 20,
		PIERCE = 10,
		LASER = -20,
		ARCANE = 20,
		HEAT = 80,
		COLD = 80,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level = 24



/mob/living/simple/cult/construct/proteon
	name = "blood cult proteon"
	icon = 'icons/mob/living/simple/cult.dmi'
	icon_state = "proteon"

	damage_type = /damagetype/unarmed/claw/

	ai = /ai

	health_base = 25
	stamina_base = 100
	mana_base = 50

	movement_delay = 1

	armor_base = list(
		BLADE = 20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 20,
		HEAT = 80,
		COLD = 80,
		HOLY = -80,
		DARK = 80,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level = 16

