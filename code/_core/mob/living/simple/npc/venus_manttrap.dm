/mob/living/simple/npc/venus_human_trap
	name = "venus human trap"
	icon = 'icons/mob/living/simple/jungle/venus_human_trap.dmi'
	icon_state = "venus_human_trap"
	damage_type = /damagetype/unarmed/claw/
	class = /class/venus_human_trap

	health_base = 100

	ai = /ai/

	stun_angle = 0

	value = 50

	armor_base = list(
		BLADE = 0,
		BLUNT = 50,
		PIERCE = 75,
		LASER = 0,
		MAGIC = 100,
		HEAT = 0,
		COLD = -25,
		BOMB = 0,
		BIO = -50,
		RAD = 75,
		HOLY = 75,
		DARK = 0,
		FATIGUE = 50
	)

	iff_tag = "jungle"
	loyalty_tag = "jungle"

	movement_delay = DECISECONDS_TO_TICKS(2)

	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/venus_human_trap/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
