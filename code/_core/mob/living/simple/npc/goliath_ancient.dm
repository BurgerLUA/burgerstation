/mob/living/simple/npc/goliath/ancient
	name = "ancient goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath_ancient.dmi'
	icon_state = "agoliath"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/ancient/

	ai = /ai/goliath/ancient

	stun_angle = 0

	health_base = 500

	attack_range = 1

	armor_base = list(
		BLADE = 75,
		BLUNT = 90,
		PIERCE = 90,
		LASER = 90,
		MAGIC = 50,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 0,
		DARK = 0,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_GIANT