/obj/item/weapon/ranged/bullet/magazine/rifle/marksman
	name = "\improper .223 MMR"
	bullet_type = ".223"
	desc = "Vanilla, but still powerful."
	desc_extended = "The .223 Mauler Marksman Rifle is THE assault rifle for private military corporations. Easy to use, accurate, and comes only in semi-automatic to train those recruits not to waste ammo."
	icon = 'icons/obj/items/weapons/ranged/rifle/223.dmi'
	icon_state = "inventory"
	value = 80

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber



	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	can_wield = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.05
	heat_max = 0.3

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_static_spread() //Base spread
	if(!wielded)
		return 0.3
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_skill_spread(var/mob/living/L) //Base spread
	return 0.02 - (0.02 * L.get_skill_power(SKILL_RANGED))