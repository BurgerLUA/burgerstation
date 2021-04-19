/mob/living/simple/venus_human_trap
	name = "venus human trap"
	icon = 'icons/mob/living/simple/jungle/venus_human_trap.dmi'
	icon_state = "venus_human_trap"
	damage_type = /damagetype/unarmed/claw/
	class = /class/venus_human_trap

	health_base = 75
	stamina_base = 25
	mana_base = 25

	ai = /ai/

	stun_angle = 0

	value = 50

	armor_base = list(
		BLADE = -20,
		PIERCE = 20,
		LASER = -20,
		ARCANE = 40,
		HEAT = -AP_CLUB,
		COLD = -20,
		BIO = -AP_GREATSWORD,
		RAD = AP_CLUB,
		FATIGUE = AP_CLUB,
		ION = INFINITY,
		PAIN = 20
	)

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	movement_delay = DECISECONDS_TO_TICKS(2)

	size = SIZE_LARGE

	blood_type = /reagent/blood/plant
	blood_volume = 400

	soul_size = SOUL_SIZE_COMMON

/mob/living/simple/venus_human_trap/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
