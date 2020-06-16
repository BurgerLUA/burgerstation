/mob/living/simple/npc/goliath/ancient
	name = "ancient goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath_ancient.dmi'
	icon_state = "agoliath"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/ancient/

	ai = /ai/goliath/ancient

	stun_angle = 0

	health_base = 500

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 1

	armor_base = list(
		BLADE = 75,
		BLUNT = 75,
		PIERCE = 75,
		LASER = -25,
		MAGIC = -25,
		HEAT = INFINITY,
		COLD = -25,
		BOMB = 75,
		BIO = 75,
		RAD = 75,
		HOLY = -25,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_GIANT