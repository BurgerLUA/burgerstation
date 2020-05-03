/obj/item/weapon/ranged/bullet/revolver/detective
	name = "\improper .38 Special revolver"
	desc = "The detective's trusty sidearm. Uses .38 revolver rounds."
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 6



	shoot_sounds = list('sounds/weapons/revolver_light/revolver.ogg')

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_2
	weight = WEIGHT_2

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	heat_per_shot = 0.03
	heat_max = 0.1

	value = 50

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.06 * L.get_skill_power(SKILL_RANGED)))