/mob/living/simple/npc/xenomorph
	name = "alien"
	desc = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien.dmi'
	icon_state = "alien"

	ai = /ai/simple/xenomorph
	damage_type = "xenomorph"
	class = "xenomorph"
	health_base = 100

	level_multiplier = 20

/mob/living/simple/npc/xenomorph/get_movement_delay()
	return DECISECONDS_TO_TICKS(3)

/mob/living/simple/npc/xenomorph/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/xenomorph/pack_leader
	ai = /ai/simple/xenomorph/pack_leader
	health_base = 100

	level_multiplier = 40

/mob/living/simple/npc/xenomorph/pack_leader/queen
	name = "alien queen"
	id = "xenomorph_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "alien_queen"
	pixel_x = -16
	health_base = 100

	ai = /ai/simple/xenomorph_queen
	damage_type = "xenomorph_queen"
	class = "xenomorph_queen"

	level_multiplier = 80

	boss = TRUE