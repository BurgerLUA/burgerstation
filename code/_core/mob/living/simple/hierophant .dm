/mob/living/simple/hierophant
	name = "hierophant"
	id = "heirophant"
	icon = 'icons/mob/living/simple/lavaland/hierophant.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/
	class = /class/ash_drake

	value = 6000

	pixel_w = -16

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
		BLADE = 25,
		BLUNT = 25,
		PIERCE = 50,
		LASER = 100,
		ARCANE = 25,
		HEAT = 100,
		COLD = -25,
		BOMB = 25,
		BIO = 25,
		RAD = 100,
		HOLY = -25,
		DARK = 100,
		FATIGUE = 25,
		ION = INFINITY
	)

	fatigue_from_block_mul = 0

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/drake_armor,
		/obj/item/soapstone/orange
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		FATIGUE = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		FIRE = TRUE
	)

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE