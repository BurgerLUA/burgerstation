/mob/living/simple/npc/spider
	name = "cave spider"
	icon = 'icons/mob/living/simple/spiders.dmi'
	icon_state = "guard"

	damage_type = "spider"

	ai = /ai/simple/spider

	class = "spider"

	stun_angle = 180

	health_base = 100

/mob/living/simple/npc/spider/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_icon()

/mob/living/simple/npc/spider/desert
	name = "desert spider"
	icon_state = "nurse"

	level_multiplier = 1.25

/mob/living/simple/npc/spider/twilight
	name = "twilight spider"
	icon_state = "hunter"

	level_multiplier = 1.5

