/obj/item/weapon/ranged/bullet/magazine/autoshotgun
	name = "\improper 12g BS"
	desc = "\"BS\" is literally and figuratively the last thing that goes through someone's mind when they see this."
	desc_extended = "The 12 Gauge Bull Shotgun is an insanely powerful semiautomatic bullpup shotgun, nicknamed \"Bull\" for its bullpup design as well as the fact that it kicks like one too."
	icon = 'icons/obj/items/weapons/ranged/shotgun/auto.dmi'
	icon_state = "inventory"
	value = 210

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapons/auto_shotgun/fire.ogg')

	can_wield = FALSE

	view_punch = 18

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

/obj/item/weapon/ranged/bullet/magazine/autoshotgun/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/autoshotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))