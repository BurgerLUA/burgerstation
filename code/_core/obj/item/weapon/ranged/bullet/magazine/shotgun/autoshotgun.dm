/obj/item/weapon/ranged/bullet/magazine/shotgun/bull
	name = "\improper 12g Double Action"
	desc = "For when you want to clear a room."
	desc_extended = "The 12 Gauge Double Action is an insanely powerful semiautomatic bullpup shotgun, nicknamed \"Bull\" for its bullpup design as well as the fact that it kicks like one too."
	icon = 'icons/obj/items/weapons/ranged/shotgun/auto.dmi'
	icon_state = "inventory"
	value = 210

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/12gauge/shoot.ogg')

	can_wield = FALSE

	view_punch = 18

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.05
	heat_max = 0.15

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	value = 300

	ai_heat_sensitivity = 0.75

/obj/item/weapon/ranged/bullet/magazine/shotgun/bull/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/shotgun/bull/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.05 - (0.1 * L.get_skill_power(SKILL_RANGED)))