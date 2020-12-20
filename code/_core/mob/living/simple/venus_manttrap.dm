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
		BLADE = -AP_SWORD,
		PIERCE = AP_SWORD,
		LASER = -AP_SWORD,
		ARCANE = AP_AXE,
		HEAT = -AP_CLUB,
		COLD = -AP_SWORD,
		BIO = -AP_GREATSWORD,
		RAD = AP_CLUB,
		FATIGUE = AP_CLUB,
		ION = INFINITY,
		PAIN = AP_SWORD
	)

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	movement_delay = DECISECONDS_TO_TICKS(2)

	mob_size = MOB_SIZE_LARGE

	blood_type = /reagent/blood/plant
	blood_volume = 400

/mob/living/simple/venus_human_trap/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
