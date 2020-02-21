/obj/item/weapon/ranged/bullet/magazine/rifle/carbine
	name = "5.56mm Carbine Rifle"
	icon = 'icons/obj/items/weapons/ranged/rifle/556.dmi'
	icon_state = "inventory"
	shoot_delay = 3
	view_punch = 4
	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

	heat_per_shot = 0.005
	heat_max = 0.05

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/carbine/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))