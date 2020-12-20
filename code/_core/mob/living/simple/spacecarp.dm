/mob/living/simple/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/sealife.dmi'
	icon_state = "carp"

	ai = /ai/carp
	damage_type = /damagetype/unarmed/bite/
	class = /class/carp/

	health_base = 150
	stamina_base = 100
	mana_base = 50

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
		BLADE = AP_AXE,
		HEAT = AP_GREATAXE,
		COLD = AP_GREATAXE,
		BIO = AP_GREATAXE,
		RAD = INFINITY,
		FATIGUE = AP_SWORD,
		ION = INFINITY,
		PAIN = AP_SWORD
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

