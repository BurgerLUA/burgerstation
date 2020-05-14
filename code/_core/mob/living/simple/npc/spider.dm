/mob/living/simple/npc/spider
	name = "cave spider"
	icon = 'icons/mob/living/simple/spiders.dmi'
	icon_state = "guard"

	damage_type = /damagetype/npc/spider

	ai = /ai/

	class = "spider"

	stun_angle = 180

	health_base = 100

	armor_base = list(
		BLADE = 10,
		BLUNT = 25,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 25,
		COLD = 25,
		BOMB = 0,
		BIO = 75,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

/mob/living/simple/npc/spider/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/spider/desert
	name = "glowspider"
	icon_state = "nurse"

	level_multiplier = 1.25

/mob/living/simple/npc/spider/desert/Initialize()
	set_light(4,0.25,"#00FF00")
	return ..()

/mob/living/simple/npc/spider/twilight
	name = "twilight spider"
	icon_state = "hunter"

	level_multiplier = 1.5

