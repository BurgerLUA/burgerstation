/mob/living/simple/cult/


	iff_tag = "Cult"
	loyalty_tag = "Cult"

	size = SIZE_HUMAN

	blood_type = /reagent/blood/unholy
	blood_volume = BLOOD_VOLUME_DEFAULT

	soul_size = SOUL_SIZE_COMMON

	level = 10

/mob/living/simple/cult/construct
	stun_angle = 0

	armor = /armor/cult_construct

	size = SIZE_GIANT

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

	movement_delay = AI_TICK

	level = 16

