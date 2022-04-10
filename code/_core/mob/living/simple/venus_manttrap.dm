/mob/living/simple/venus_human_trap
	name = "venus human trap"
	icon = 'icons/mob/living/simple/jungle/venus_human_trap.dmi'
	icon_state = "venus_human_trap"
	damage_type = /damagetype/unarmed/claw/


	health_base = 75
	stamina_base = 25
	mana_base = 25

	ai = /ai/

	stun_angle = 0

	value = 50

	armor = /armor/plant

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	movement_delay = DECISECONDS_TO_TICKS(2)

	size = SIZE_GIANT

	blood_type = /reagent/blood/plant
	blood_volume = 400

	soul_size = SOUL_SIZE_COMMON

	level = 12

/mob/living/simple/venus_human_trap/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
