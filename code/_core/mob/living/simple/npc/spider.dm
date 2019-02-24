/mob/living/simple/npc/spider
	name = "cave spider"
	icon = 'icons/mob/living/simple/animal.dmi'
	icon_state = "guard"

	damage_type = "spider"

	ai = /ai/spider

	class = "spider"

/mob/living/simple/npc/spider/get_movement_delay()
	return SECONDS_TO_TICKS(1)