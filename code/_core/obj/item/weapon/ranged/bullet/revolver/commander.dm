/obj/item/weapon/ranged/bullet/revolver/commander
	name = "\improper .44 Commander Autorevolver"
	desc = "Semi-automatic!"
	icon = 'icons/obj/items/weapons/ranged/revolver/44.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sounds/weapons/revolver_heavy/shoot.ogg')

	view_punch = 10

	size = SIZE_2
	weight = WEIGHT_3

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 10
	bullet_diameter_best = 10.9
	bullet_diameter_max = 11

	value = 170

	heat_per_shot = 0.03
	heat_max = 0.1

/obj/item/weapon/ranged/bullet/revolver/commander/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/revolver/commander/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.05 - (0.1 * L.get_skill_power(SKILL_RANGED)))