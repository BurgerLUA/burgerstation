/mob/abstract/
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE



var/global/mob/abstract/melee_checker

/mob/abstract/melee_checker
	name = "melee checker"
	collision_flags = FLAG_COLLISION_FLYING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	layer = LAYER_GHOST
	invisibility = 100
	invisibility = 101
	alpha        = 0
	opacity      = 0
	see_in_dark  = 1e6 // Literally arbitrary.
	density = TRUE

/mob/abstract/melee_checker/New(var/desired_loc)
	melee_checker = src
	return ..()