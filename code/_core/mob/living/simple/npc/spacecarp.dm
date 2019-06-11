/mob/living/simple/npc/spacecarp/
	name = "space carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/sealife.dmi'
	icon_state = "carp"

	ai = /ai/carp
	damage_type = "carp_bite"
	class = "carp"

	collision_flags = FLAG_COLLISION_FLYING | FLAG_COLLISION_SWIMMING

/mob/living/simple/npc/spacecarp/leader
	name = "alpha space carp"
	class = "carp"
	level_multiplier = 2