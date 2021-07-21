/obj/item/weapon/ranged/bullet/revolver/gauss //you know what we need? more gauss
	name = "\improper 2x12 ball Gauss Blunderbuss"
	desc = "A dangerous mutation made by anarchists and bandits used to stop Duty's march." //I had to, ok?
	desc_extended = "This weapon is the product of bad luck and resourcefulness. By using salvaged parts from broken Gauss rifles, this Blunderbuss can shoot as hard as one with half the size and one-eighth of the ammo capacity."
	icon = 'icons/obj/item/weapons/ranged/revolver/gauss_blunder.dmi'
	icon_state = "inventory"
	value = 600

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 1

	shoot_sounds = list('sound/weapons/russia/gauss.ogg')

	size = SIZE_1
	weight = 2

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 14

	bullet_diameter_min = 1
	bullet_diameter_best = 2
	bullet_diameter_max = 3

	heat_per_shot_mod = 2 //i have no idea what this'll do, but I sure hope it doesn't cause heat to go over 0.2
	heat_max = 0.2
	view_punch_mod = 0

	inaccuracy_modifier = 3
	movement_inaccuracy_modifier = 4
	movement_spread_base = 0.3

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_static_spread()
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_skill_spread(var/mob/living/L)
	return max(0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))