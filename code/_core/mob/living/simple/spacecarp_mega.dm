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
		BLADE = AP_AXE,
		BLUNT = AP_DAGGER,
		PIERCE = AP_AXE,
		LASER = -AP_SWORD,
		ARCANE = AP_SWORD,
		HEAT = AP_GREATSWORD,
		COLD = AP_GREATSWORD,
		BIO = AP_GREATSWORD,
		RAD = INFINITY,
		HOLY = AP_AXE,
		DARK = AP_AXE,
		FATIGUE = AP_GREATSWORD,
		ION = INFINITY,
		PAIN = AP_GREATSWORD
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

