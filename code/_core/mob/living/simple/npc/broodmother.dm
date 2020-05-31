/mob/living/simple/npc/goliath/broodmother
	name = "goliath broodmother"
	id = "broodmother"
	icon = 'icons/mob/living/simple/lavaland/goliath_broodmother.dmi'
	icon_state = "broodmother"
	damage_type = /damagetype/unarmed/claw/
	class = "broodmother"

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

	butcher_contents = list(
		/obj/item/clothing/overwear/armor/bone_armor,
		/obj/item/soapstone/red
	)