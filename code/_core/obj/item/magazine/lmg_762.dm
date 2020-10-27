/obj/item/magazine/lmg_762
	name = "\improper 7.62mm drum magazine."
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/762_lmg.dmi'
	icon_state = "lmg"
	bullet_count_max = 40

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/nato

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_3

	icon_states = 1

	value = 20