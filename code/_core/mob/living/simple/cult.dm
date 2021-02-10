/mob/living/simple/cult/
	class = /class/cult

	iff_tag = "Cult"
	loyalty_tag = "Cult"

	size = SIZE_HUMAN

	blood_type = /reagent/blood/unholy
	blood_volume = BLOOD_VOLUME_DEFAULT

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
		BLADE = AP_SWORD,
		BLUNT = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		COLD = AP_SWORD,
		HOLY = -AP_CLUB,
		DARK = AP_CLUB,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
	)

	level_multiplier = 1

/mob/living/simple/cult/cultist/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	return .

/mob/living/simple/cult/construct
	stun_angle = 0

	size = SIZE_LARGE

	blood_type = /reagent/blood/unholy
	blood_volume = 1000

	has_footsteps = FALSE

/mob/living/simple/cult/construct/post_death()
	. = ..()
	icon_state = "construct_dead"
	return .

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
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_DAGGER,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = INFINITY,
		ION = 0,
		PAIN = INFINITY
	)

	level_multiplier = 5

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
		BLADE = AP_CLUB,
		BLUNT = AP_CLUB,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = -AP_DAGGER,
		HEAT = AP_CLUB,
		COLD = AP_CLUB,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level_multiplier = 2

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
		BLADE = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level_multiplier = 1

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
		BLADE = AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_AXE,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level_multiplier = 10

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
		BLADE = AP_SWORD,
		PIERCE = AP_DAGGER,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		HOLY = -AP_GREATSWORD,
		DARK = AP_GREATSWORD,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	level_multiplier = 3