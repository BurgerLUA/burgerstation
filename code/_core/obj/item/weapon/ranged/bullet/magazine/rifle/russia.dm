/obj/item/weapon/ranged/bullet/magazine/rifle/russian
	name = "\improper 7.62x39mm AK-13"
	desc = "Vanilla, but still powerful."
	desc_extended = "The .308 Mauler Marksman Rifle is THE dmr for private military corporations. Easy to use, accurate, and comes only in semi-automatic to train those recruits not to waste ammo."
	icon = 'icons/obj/items/weapons/ranged/rifle/762_russia.dmi'
	icon_state = "inventory"
	value = 100

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/308/shoot_short.ogg')

	can_wield = TRUE

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_3

	heat_per_shot = 0.02
	heat_max = 0.3

	bullet_length_min = 37
	bullet_length_best = 38
	bullet_length_max = 39

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/russian/get_static_spread() //Base spread
	if(!wielded)
		return 0.15
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/russian/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))