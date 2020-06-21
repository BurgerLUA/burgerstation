/mob/living/simple/npc/goliath/broodmother
	name = "goliath broodmother"
	id = "broodmother"
	icon = 'icons/mob/living/simple/lavaland/goliath_broodmother.dmi'
	icon_state = "broodmother"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/broodmother

	ai = /ai/goliath/broodmother

	stun_angle = 0

	health_base = 3000

	var/boss_state = 0
	//0 = walking
	//1 = flying
	//2 = landing

	attack_range = 1

	force_spawn = TRUE
	boss = TRUE

	armor_base = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 100,
		MAGIC = 0,
		HEAT = INFINITY,
		COLD = 0,
		BOMB = 75,
		BIO = 75,
		RAD = 75,
		HOLY = 25,
		DARK = INFINITY,
		FATIGUE = INFINITY
	)

	status_immune = list(
		STUN = TRUE,
		SLEEP = STAGGER,
		PARALYZE = STAGGER,
		FATIGUE = STAGGER,
		STAGGER = FALSE,
		CONFUSED = FALSE,
		CRIT = FALSE,
		REST = FALSE,
		ADRENALINE = FALSE,
		DISARM = FALSE,
		DRUGGY = FALSE
	)

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/bone_armor,
		/obj/item/soapstone/red
	)

	damage_received_multiplier = 0.5

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE