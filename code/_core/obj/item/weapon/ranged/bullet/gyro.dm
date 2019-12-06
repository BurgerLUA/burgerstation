/obj/item/weapon/ranged/bullet/magazine/gyrojet
	name = "\improper 20mm gyropistol"
	icon = 'icons/obj/items/weapons/ranged/gyrojet_pistol.dmi'
	icon_state = "inventory"

	shoot_delay = 8

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "gyrojet"

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	view_punch = 2

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

/obj/item/weapon/ranged/bullet/magazine/gyrojet/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/gyrojet/get_skill_spread(var/mob/living/L) //Base spread
	return 0.3 - (0.3 * L.get_skill_power(SKILL_RANGED))





/obj/item/weapon/ranged/bullet/magazine/gyrojet/rifle
	name = "\improper 20mm gyrorifle"
	icon = 'icons/obj/items/weapons/ranged/gyrojet_rifle.dmi'
	icon_state = "inventory"

	shoot_delay = 8

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "gyrojet"

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

/obj/item/weapon/ranged/bullet/magazine/gyrojet/rifle/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/gyrojet/rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.2 - (0.2 * L.get_skill_power(SKILL_RANGED))