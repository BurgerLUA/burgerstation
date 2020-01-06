/obj/item/weapon/ranged/bullet/revolver/deckhard
	name = "\improper .44 space detective revolver"
	desc = "A sidearm commonly used by space police. Uses .44 rounds."
	icon = 'icons/obj/items/weapons/ranged/deckhard_mine.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 8

	automatic = TRUE

	bullet_count_max = 6

	bullet_type = ".44"

	shoot_sounds = list('sounds/weapons/deckhard/shot.ogg')

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_skill_spread(var/mob/living/L) //Base spread
	return 0.02 - (0.02 * L.get_skill_power(SKILL_RANGED))