/obj/item/weapon/ranged/bullet/magazine/pistol/military
	name = ".40 Civil Defense Pistol"
	desc = "Even more tactical than the tactical pistol."
	desc_extended = "A military grade pistol amazingly chambered in .40. It shoots significantly faster than its tactical counterpart."
	value = 70
	icon = 'icons/obj/items/weapons/ranged/pistol/40.dmi'
	shoot_delay = 1.5
	shoot_sounds = list('sounds/weapons/40/shoot.ogg')

	view_punch = 7

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2

	heat_per_shot = 0.03
	heat_max = 0.1

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

/obj/item/weapon/ranged/bullet/magazine/pistol/military/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/pistol/military/get_skill_spread(var/mob/living/L) //Base spread
	return 0.03 - (0.03 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod
	name = ".40 Civil Defense Pistol MOD"
	icon = 'icons/obj/items/weapons/ranged/pistol/40_2.dmi'
	desc_extended = "A modified variant of the .40 Military Pistol. The slider has been shortened, the frame replaced with lighter materials, and a recoil compensator was added for extra accuracy."
	value = 110
	shoot_sounds = list('sounds/weapons/40/shoot_mod.ogg')
	shoot_delay = 1

	view_punch = 5

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_1

	heat_per_shot = 0.01
	heat_max = 0.1

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod/get_heat_spread()
	return ..() * 0.5