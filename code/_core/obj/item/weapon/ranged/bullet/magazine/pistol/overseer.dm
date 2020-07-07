/obj/item/weapon/ranged/bullet/magazine/pistol/overseer
	name = "\improper 12.7mm High-Power Auto"
	desc = "The \"Auto\" is for semiauto."
	desc_extended = "A very powerful semiautomatic pistol designed for high ranking NanoTrasen commanders. The bulkiness of the pistol rivals submachine guns."
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm_nt.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/12/shoot.ogg')

	can_wield = FALSE

	view_punch = 20

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_2
	weight = WEIGHT_3

	heat_per_shot = 0.06
	heat_max = 0.10

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))