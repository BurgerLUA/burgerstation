/mob/living/simple/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/sealife.dmi'
	icon_state = "carp"

	ai = /ai/carp
	damage_type = /damagetype/unarmed/bite/
	class = /class/carp/

	health_base = 150

	value = 100

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/,
		/obj/item/container/food/dynamic/fish/raw_carp/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	loyalty_tag = "Carp"
	iff_tag = "Carp"

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		ARCANE = 75,
		HEAT = 50,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 75,
		FATIGUE = 25,
		ION = INFINITY,
		PAIN = 25
	)

	mob_size = MOB_SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(1.5)

	has_footsteps = FALSE

	stun_angle = 180

	blood_type = /reagent/blood/carp

/mob/living/simple/spacecarp/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/spacecarp/leader
	name = "alpha space carp"
	class = /class/carp
	level_multiplier = 1.25

