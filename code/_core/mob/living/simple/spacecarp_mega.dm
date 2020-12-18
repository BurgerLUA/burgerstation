/mob/living/simple/megacarp
	name = "space megacarp"
	icon = 'icons/mob/living/simple/megacarp.dmi'
	icon_state = "living"

	damage_type = /damagetype/unarmed/bite/
	class = /class/carp/

	health_base = 300

	value = 400

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	armor_base = list(
		BLADE = 75,
		BLUNT = 50,
		PIERCE = 50,
		LASER = 0,
		ARCANE = 25,
		HEAT = 75,
		COLD = 100,
		BOMB = 50,
		BIO = 75,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 75,
		FATIGUE = 50,
		ION = INFINITY,
		PAIN = 50
	)

	mob_size = MOB_SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(2)

	has_footsteps = FALSE

	pixel_x = -16

	level_multiplier = 3

	loyalty_tag = "Shark"
	iff_tag = "Shark"

	blood_type = /reagent/blood/carp
	blood_volume = 750

