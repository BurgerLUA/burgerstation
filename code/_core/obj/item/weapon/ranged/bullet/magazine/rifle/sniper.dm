/obj/item/weapon/ranged/bullet/magazine/rifle/sniper
	name = "\improper 7.62mm Sniper Rifle"
	desc = "For when you want to be an asshole at an extended range."
	icon = 'icons/obj/items/weapons/ranged/rifle/762.dmi'
	icon_state = "inventory"


	projectile_speed = 31
	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/sniper_heavy/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 32

	slowdown_mul_held = HELD_SLOWDOWN_SNIPER_LARGE

	size = SIZE_4
	weight = WEIGHT_5

	heat_per_shot = 0.07
	heat_max = 0.3

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4
	weight = WEIGHT_5

	value = 400

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))