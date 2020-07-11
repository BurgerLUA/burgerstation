/obj/item/weapon/ranged/bullet/revolver/deckhard
	name = "\improper .44 space detective revolver"
	desc = "A sidearm commonly used by space police. Uses .44 rounds."
	desc_extended = "While Semiautos have become standard issue for Space Police, diehard Seargeants still tout the higher reliability of a revolver as a reason to carry these."
	icon = 'icons/obj/item/weapons/ranged/deckhard_mine.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 6

	automatic = TRUE

	bullet_count_max = 6



	shoot_sounds = list('sound/weapons/deckhard/shot.ogg')

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_2


	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 10
	bullet_diameter_best = 10.9
	bullet_diameter_max = 11

	heat_per_shot = 0.04
	heat_max = 0.1

	value = 60

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))