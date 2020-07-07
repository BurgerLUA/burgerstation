/mob/living/simple/npc/venus_human_trap
	name = "venus human trap"
	icon = 'icons/mob/living/simple/jungle/venus_human_trap.dmi'
	icon_state = "venus_human_trap"
	damage_type = /damagetype/unarmed/claw/
	class = /class/venus_human_trap

	ai = /ai/

	stun_angle = 0

	value = 50

	armor_base = list(
		BLADE = 10,
		BLUNT = 25,
		PIERCE = 10,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

	iff_tag = "jungle"
	loyalty_tag = "jungle"

	movement_delay = DECISECONDS_TO_TICKS(2)

	mob_size = MOB_SIZE_LARGE

/mob/living/simple/npc/venus_human_trap/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()
