/obj/item/weapon/ranged/bullet/magazine/rifle/marksman
	name = "\improper .308 Marksman Rifle"
	desc = "Vanilla, but still powerful."
	desc_extended = "The .308 Mauler Marksman Rifle is THE dmr for private military corporations. Easy to use, accurate, and comes only in semi-automatic to train those recruits not to waste ammo."
	icon = 'icons/obj/items/weapons/ranged/rifle/308.dmi'
	icon_state = "inventory"
	value = 80

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.03
	heat_max = 0.1

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	value = 150

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod
	name = "\improper .308 Marksman Rifle MOD"
	icon = 'icons/obj/items/weapons/ranged/rifle/308_mod.dmi'

	heat_per_shot = 0.06
	heat_max = 0.2

	size = SIZE_3
	weight = WEIGHT_3

	value = 200

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0.05