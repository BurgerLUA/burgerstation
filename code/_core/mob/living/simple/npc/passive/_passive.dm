/mob/living/simple/npc/passive
	name = "passive creature"

	icon = 'icons/mob/living/simple/passive.dmi'
	icon_state = ""

	ai = /ai/passive
	class = "passive"
	damage_type = "passive"

/mob/living/simple/npc/passive/get_movement_delay()
	return SECONDS_TO_TICKS(8)

/mob/living/simple/npc/passive/get_attack_delay()
	return SECONDS_TO_DECISECONDS(4)