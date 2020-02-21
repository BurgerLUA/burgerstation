/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet
	name = "\improper 20mm GyroPistol"
	desc = "Overdesigned and a little overpowered."
	desc = "A prototype syndicate pistol that uses minature rockets as projectiles."
	icon = 'icons/obj/items/weapons/ranged/pistol/gyrojet.dmi'
	icon_state = "inventory"
	value = 140

	shoot_delay = 8

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	shoot_sounds = list('sounds/weapons/gyrojet/shoot.ogg')

	view_punch = 2

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_2
	weight = WEIGHT_3

	heat_per_shot = 0.02
	heat_max = 0.1

	bullet_length_min = 48
	bullet_length_best = 50
	bullet_length_max = 52

	bullet_diameter_min = 19
	bullet_diameter_best = 20
	bullet_diameter_max = 21

/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet/get_skill_spread(var/mob/living/L) //Base spread
	return 0.3 - (0.3 * L.get_skill_power(SKILL_RANGED))