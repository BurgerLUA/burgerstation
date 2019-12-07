/obj/item/weapon/ranged/bullet/magazine/autoshotgun
	name = "\improper 12 gauge autoshotgun"
	icon = 'icons/obj/items/weapons/ranged/riot_shotgun.dmi'
	icon_state = "inventory"

	shoot_delay = 4

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapons/auto_shotgun/fire.ogg')

	can_wield = FALSE

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/weapon/ranged/bullet/magazine/autoshotgun/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/autoshotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))