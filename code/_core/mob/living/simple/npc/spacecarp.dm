/mob/living/simple/npc/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/sealife.dmi'
	icon_state = "carp"

	ai = /ai/simple/carp
	damage_type = /damagetype/unarmed/bite/
	class = "carp"

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/mob/living/simple/npc/spacecarp/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/npc/spacecarp/leader
	name = "alpha space carp"
	class = "carp"
	level_multiplier = 1.25

