/mob/living/simple/npc/crab
	name = "crab"
	icon = 'icons/mob/living/simple/crab.dmi'
	icon_state = "crab"
	damage_type = "crab_claw"
	class = "crab"

	ai = /ai/crab

/mob/living/simple/npc/crab/passive
	ai = /ai/passive
	can_attack_while_moving = FALSE

/mob/living/simple/npc/crab/king
	name = "king crab"
	icon = 'icons/mob/living/simple/crab_king.dmi'
	icon_state = "king"
	pixel_x = -32
	pixel_y = 0

	health_base = 1000

	ai = /ai/king_crab

	class = "crab"
	level_multiplier = 100

	attack_range = 3

	density = 1

/mob/living/simple/npc/crab/king/get_movement_delay()
	return SECONDS_TO_TICKS(1)

/mob/living/simple/npc/crab/king/get_attack_delay()
	return SECONDS_TO_DECISECONDS(1)

