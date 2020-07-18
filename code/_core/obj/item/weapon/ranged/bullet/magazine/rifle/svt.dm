/obj/item/weapon/ranged/bullet/magazine/rifle/svt
	name = "\improper 7.62x54mmR SVT-40"
	desc = "URAAAAAAAAAAA!"
	desc_extended = "The SVT-40 is a Russian Rifle most well known for killing Nazis. Now you too can carry that legacy in your hands!"
	icon = 'icons/obj/item/weapons/ranged/rifle/762_svt.dmi'
	icon_state = "inventory"
	value = 300

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4


	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 46
	bullet_length_best = 54
	bullet_length_max = 58

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/svt/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/svt/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.01 - (0.15 * L.get_skill_power(SKILL_RANGED)))
