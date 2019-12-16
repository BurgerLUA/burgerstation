/obj/item/weapon/ranged/bullet/revolver/detective
	name = "\improper .38 Special revolver"
	desc = "The detective's trusty sidearm. Uses .38 revolver rounds."
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 6

	automatic = FALSE

	bullet_count_max = 6

	bullet_type = ".38"

	shoot_sounds = list('sounds/weapons/revolver_light/revolver.ogg')

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))