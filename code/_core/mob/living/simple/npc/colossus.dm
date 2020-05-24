/mob/living/simple/npc/colossus
	name = "colossus"
	id = "colossus"
	icon = 'icons/mob/living/simple/lavaland/colossus.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = "ash_drake"

	pixel_x = -16

	ai = /ai/boss/ash_drake/

	stun_angle = 0

	health_base = 2000

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 2

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = -25,
		MAGIC = -25,
		HEAT = INFINITY,
		COLD = -25,
		BOMB = 50,
		BIO = 75,
		RAD = 75,
		HOLY = 0,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)