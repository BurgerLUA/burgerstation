/mob/living/simple/npc/xeno/queen
	name = "xeno queen"
	id = "xeno_queen"
	icon = 'icons/mob/living/simple/alien_queen.dmi'
	icon_state = "living"
	pixel_x = -16
	health_base = 1000
	value = 2000

	armor_base = list(
		BLADE = 100,
		BLUNT = 75,
		PIERCE = 100,
		LASER = 50,
		ARCANE = 50,
		HEAT = 75,
		COLD = 75,
		BOMB = 50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 100,
		FATIGUE = 50,
		ION = INFINITY
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
		FIRE = FALSE
	)

	ai = /ai/xeno
	damage_type = /damagetype/npc/xeno/queen
	class = /class/xeno

	boss = TRUE
	force_spawn = TRUE

	movement_delay = DECISECONDS_TO_TICKS(2)

	level_multiplier = 10

	butcher_contents = list(
		/obj/item/soapstone/orange,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/,
		/obj/item/container/food/dynamic/meat/xeno/
	)

	damage_received_multiplier = 0.5
	fatigue_from_block_mul = 0

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	can_leap = FALSE
	can_spit = TRUE