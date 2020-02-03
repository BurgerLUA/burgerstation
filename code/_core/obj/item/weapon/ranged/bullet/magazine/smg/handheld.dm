/obj/item/weapon/ranged/bullet/magazine/smg/handheld
	name = "\improper 9mm SMP"
	icon = 'icons/obj/items/weapons/ranged/smg/9mm.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "9mm"

	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

	can_wield = FALSE

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_3
	weight = WEIGHT_3

/obj/item/weapon/ranged/bullet/magazine/smg/handheld/get_static_spread() //Base spread
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/smg/handheld/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))