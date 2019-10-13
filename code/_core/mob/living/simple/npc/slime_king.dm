/mob/living/simple/npc/slime_king //Not a subtype of slime because it behaves way differently
	name = "slime king"
	id = "slime_king"
	desc = "Oh no. They're here too."

	icon = 'icons/mob/living/simple/slime_king.dmi'
	icon_state = "king"

	ai = /ai/simple/king_crab

	can_attack_while_moving = TRUE

	color = "#2222FF"

	pixel_x = -32
	pixel_y = -12

	health_base = 750

	level_multiplier = 4

	object_size = 1

	attack_range = 2

	boss = TRUE