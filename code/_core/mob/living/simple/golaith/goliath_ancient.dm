/mob/living/simple/goliath/ancient
	name = "ancient goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath_ancient.dmi'
	icon_state = "agoliath"
	damage_type = /damagetype/unarmed/claw/
	class = /class/goliath/ancient/

	ai = /ai/goliath/ancient

	stun_angle = 0

	health_base = 400

	attack_range = 1

	armor_base = list(
		BLADE = 75,
		BLUNT = 90,
		PIERCE = 90,
		LASER = 90,
		ARCANE = 50,
		HEAT = 100,
		COLD = 100,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 0,
		DARK = 0,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	mob_size = MOB_SIZE_GIANT

	blood_type = /reagent/blood/ancient
	blood_volume = 1000

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_goliath,
		/obj/item/container/food/dynamic/meat/raw_goliath
	)