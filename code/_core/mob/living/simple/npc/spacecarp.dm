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
		/obj/item/container/food/dynamic/meat/fish/,
		/obj/item/container/food/dynamic/meat/fish/,
		/obj/item/container/food/dynamic/meat/fish/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	loyalty_tag = "carp"
	iff_tag = "carp"

	armor_base = list(
		BLADE = 25,
		BLUNT = 0,
		PIERCE = 25,
		LASER = -25,
		MAGIC = -25,
		HEAT = INFINITY,
		COLD = INFINITY,
		BOMB = 0,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
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

