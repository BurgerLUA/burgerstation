/mob/living/simple/npc/xenomorph
	name = "xenomorph"
	desc = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien.dmi'
	icon_state = "alien"

	ai = /ai/simple/xenomorph
	damage_type = "xenomorph"
	class = "xenomorph"
	health_base = 100

/mob/living/simple/npc/xenomorph/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/xenomorph/pack_leader
	ai = /ai/simple/xenomorph/pack_leader
	health_base = 100

	level_multiplier = 2

/mob/living/simple/npc/xenomorph/pack_leader/queen
	name = "xenomorph queen"
	id = "xenomorph_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "alien_queen"
	pixel_x = -16
	health_base = 100

	ai = /ai/simple/xenomorph_queen
	damage_type = "xenomorph_queen"
	class = "xenomorph_queen"

	boss = TRUE