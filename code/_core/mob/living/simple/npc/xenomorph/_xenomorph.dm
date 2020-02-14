/mob/living/simple/npc/xenomorph
	name = "xenomorph"
	desc = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien.dmi'
	icon_state = "alien"

	ai = /ai/xenomorph
	damage_type = "xenomorph"
	class = "xenomorph"
	health_base = 100

/mob/living/simple/npc/xenomorph/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/xenomorph/pack_leader
	ai = /ai/xenomorph/pack_leader
	health_base = 100

	level_multiplier = 1.25

/mob/living/simple/npc/xenomorph/pack_leader/queen
	name = "xenomorph queen"
	id = "xenomorph_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "alien_queen"
	pixel_x = -16
	health_base = 100

	ai = /ai/xenomorph_queen
	damage_type = "xenomorph_queen"
	class = "xenomorph"

	boss = TRUE
	force_spawn = TRUE