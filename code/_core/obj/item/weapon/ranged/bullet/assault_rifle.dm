/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	name = "\improper 5.56mm Mauler assault rifle"
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 2

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "5.56mm"

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	can_wield = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))