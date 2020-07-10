/mob/living/simple/npc/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/sealife.dmi'
	icon_state = "carp"

	ai = /ai/carp
	damage_type = /damagetype/unarmed/bite/
	class = /class/carp/

	health_base = 200

	value = 100

	butcher_contents = list(
		/obj/item/container/food/dynamic/fish/,
		/obj/item/container/food/dynamic/fish/,
		/obj/item/container/food/dynamic/fish/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	loyalty_tag = "carp"
	iff_tag = "carp"

	armor_base = list(
		BLADE = 50,
		BLUNT = 25,
		PIERCE = 25,
		LASER = 0,
		MAGIC = 75,
		HEAT = 50,
		COLD = 100,
		BOMB = 25,
		BIO = 75,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 75,
		FATIGUE = 25
	)

	mob_size = MOB_SIZE_LARGE

	movement_delay = DECISECONDS_TO_TICKS(1.5)

	has_footsteps = FALSE

/mob/living/simple/npc/spacecarp/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/spacecarp/leader
	name = "alpha space carp"
	class = /class/carp
	level_multiplier = 1.25

