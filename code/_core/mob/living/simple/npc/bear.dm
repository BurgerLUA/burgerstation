/mob/living/simple/npc/bear
	name = "brown bear"
	icon = 'icons/mob/living/simple/bears.dmi'
	icon_state = "brown"
	damage_type = "bear_claw"
	class = "bear"

	ai = /ai/simple/bear

	stun_angle = 90

	health_base = 200

/mob/living/simple/npc/bear/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/bear/snow
	name = "snow bear"
	icon_state = "white"

	health_base = 300
	level_multiplier = 2