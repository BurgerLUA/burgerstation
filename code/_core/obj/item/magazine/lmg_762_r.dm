/obj/item/magazine/lmg_762_r
	name = "\improper 7.62x54mmR LMG magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/762_lmg_r.dmi'
	icon_state = "545"
	bullet_count_max = 100

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/pkm = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/long
	ammo_surplus = /obj/item/bullet_cartridge/rifle_308/long/surplus

	bullet_length_min = 53
	bullet_length_best = 54
	bullet_length_max = 55

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.62

	size = SIZE_3

	icon_states = 11

	value = 30