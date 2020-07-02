/obj/item/weapon/ranged/bullet/revolver/nagant
	name = "\improper 7.62x38mmR Nagant Revolver"
	desc = "A dusty old revolver."
	desc_extended = "The Nagant is difficult to use, but it pays off in durability and reliability."
	icon = 'icons/obj/item/weapons/ranged/revolver/762.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 7

	insert_limit = 7

	view_punch = 3

	shoot_sounds = list('sound/weapons/revolver_light/revolver.ogg')

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_3
	weight = WEIGHT_2

	bullet_length_min = 36
	bullet_length_best = 38
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7


	heat_per_shot = 0.03
	heat_max = 0.1

	value = 60

/obj/item/weapon/ranged/bullet/revolver/nagant/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/revolver/nagant/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.06 * L.get_skill_power(SKILL_RANGED)))