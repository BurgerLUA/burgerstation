/obj/item/weapon/ranged/bullet/magazine/rifle/nt_lmg
	name = "\improper 7.62 LMG"
	desc = "What's betweeen you and 100 Syndicate? This LMG."
	desc_extended = "An extremely pricy 7.62mm Light Machine Gun that was originally inteded for use in mounted placements is now available for use in combat situations."
	icon = 'icons/obj/items/weapons/ranged/rifle/762_lmg.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sounds/weapons/sniper_heavy/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 20

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE_LARGE

	size = SIZE_5
	weight = WEIGHT_4

	heat_per_shot = 0.03
	heat_max = 0.3

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_6
	weight = WEIGHT_6

	value = 1000

	ai_heat_sensitivity = 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/nt_lmg/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/rifle/nt_lmg/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.1 - (0.1 * L.get_skill_power(SKILL_RANGED)))