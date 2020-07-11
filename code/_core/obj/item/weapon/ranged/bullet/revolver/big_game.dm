/obj/item/weapon/ranged/bullet/revolver/big_game
	name = "\improper .300 Big Game Revolver"
	desc = "Can't spell overkill without .300."
	desc_extended = "A BFR (Big Frame Revolver) that has to be reloaded manually, but packs a big punch. Commonly used by Megafauna hunters."
	icon = 'icons/obj/item/weapons/ranged/revolver/300.dmi'
	icon_state = "inventory"

	shoot_delay = 6

	automatic = FALSE

	bullet_count_max = 5

	shoot_sounds = list('sound/weapons/308/big_game.ogg')

	view_punch = 24

	size = SIZE_3


	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	bullet_length_min = 40
	bullet_length_best = 46
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	value = 450

	heat_per_shot = 0.04
	heat_max = 0.1

/obj/item/weapon/ranged/bullet/revolver/big_game/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/big_game/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.04 * L.get_skill_power(SKILL_RANGED)))