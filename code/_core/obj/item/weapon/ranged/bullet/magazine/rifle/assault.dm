/obj/item/weapon/ranged/bullet/magazine/rifle/assault
	name = "\improper .308 Assault Rifle"
	desc = "For when you have money to spend on ammo."
	desc_extended = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	icon = 'icons/obj/items/weapons/ranged/rifle/308_adv.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 10

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_5

	heat_per_shot = 0.04
	heat_max = 0.08

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 0.75