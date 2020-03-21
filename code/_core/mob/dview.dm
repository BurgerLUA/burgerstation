// Dummy mob.
/mob/abstract/dview
	// Can't make it invisible enough.
	invisibility = 101
	alpha        = 0
	opacity      = 0

	see_in_dark  = 1e6 // Literally arbitrary.

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE