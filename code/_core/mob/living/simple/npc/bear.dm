/mob/living/simple/npc/bear
	name = "brown bear"
	icon = 'icons/mob/living/simple/bears.dmi'
	icon_state = "brown"
	damage_type = /damagetype/unarmed/claw/
	class = "bear"

	ai = /ai/

	stun_angle = 90

	armor_base = list(
		BLADE = 10,
		BLUNT = 25,
		PIERCE = 10,
		LASER = -25,
		MAGIC = 0,
		HEAT = 0,
		COLD = 25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

	health_base = 200

/mob/living/simple/npc/bear/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/bear/snow
	name = "snow bear"
	icon_state = "white"

	level_multiplier = 1.25

	armor_base = list(
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = 0,
		HEAT = -25,
		COLD = 75,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)