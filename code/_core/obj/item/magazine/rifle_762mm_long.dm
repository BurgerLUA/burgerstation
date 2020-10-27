/obj/item/magazine/rifle_762_long
	name = "\improper 7.62x54mmR rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/762_rifle_long.dmi'
	icon_state = "762l"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/svt = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/svd = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/long

	bullet_length_min = 46
	bullet_length_best = 54
	bullet_length_max = 58

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2

	icon_states = 1

	value = 10