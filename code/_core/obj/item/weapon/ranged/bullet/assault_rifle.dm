/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	name = "\improper 5.56mm Mauler assault rifle"
	desc = "The only rifle you'll ever need."
	desc_extended = "The Mauler 5.56mm assault rifle is THE assault rifle for private military corporations. Easy to use, accurate, and comes only in semi-automatic to train those recruits not to waste ammo."
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "5.56mm"

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	can_wield = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_static_spread() //Base spread
	if(!wielded)
		return 0.3
	return 0

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))


/obj/item/weapon/ranged/bullet/magazine/assault_rifle/bullpup
	name = "\improper 5.56mm bullpup assault rifle"
	icon = 'icons/obj/items/weapons/ranged/rifle.dmi'
	icon_state = "inventory"

	shoot_delay = 1.5

	view_punch = 7

	size = SIZE_3
	weight = WEIGHT_4

	can_wield = FALSE

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/bullpup/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/bullpup/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))