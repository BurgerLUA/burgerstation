/mob/living/simple/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/carp.dmi'
	icon_state = "base"

	ai = /ai/carp
	damage_type = /damagetype/unarmed/bite/


	health_base = 150
	stamina_base = 100
	mana_base = 50

	value = 100

	butcher_contents = list(
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/
	)

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	loyalty_tag = "Carp"
	iff_tag = "Carp"

	armor = /armor/carp

	size = SIZE_LARGE

	movement_delay = AI_TICK //I'm fast as fuck boi.

	has_footsteps = FALSE

	stun_angle = 180

	blood_type = /reagent/blood/carp

	soul_size = SOUL_SIZE_COMMON

	level = 16

/mob/living/simple/spacecarp/Generate()
	. = ..()
	color = hsv(rand(0,1536), 175, 200)

/mob/living/simple/spacecarp/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]_mouth")
	I.appearance_flags = appearance_flags | RESET_COLOR
	add_overlay(I)

/mob/living/simple/spacecarp/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/spacecarp/leader
	name = "alpha space carp"

	level = 30

