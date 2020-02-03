/obj/item/weapon/ranged/bullet/revolver/commander
	name = "\improper .44 Commander Autorevolver"
	desc = "Semi-automatic!"
	icon = 'icons/obj/items/weapons/ranged/revolver/44.dmi'
	icon_state = "inventory"

	shoot_delay = 5

	automatic = FALSE

	bullet_count_max = 6

	bullet_type = ".44"

	shoot_sounds = list('sounds/weapons/revolver_heavy/shoot.ogg')

	view_punch = 10

	size = SIZE_2
	weight = WEIGHT_3

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

/obj/item/weapon/ranged/bullet/revolver/commander/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/revolver/commander/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))