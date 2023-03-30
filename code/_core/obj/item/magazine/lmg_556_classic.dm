/obj/item/magazine/lmg_556_classic
	name = "\improper 5.56mm classic lmg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/556_lmg_classic.dmi'
	icon_state = "556"
	bullet_count_max = 100

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_classic = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_223/nato
	ammo_surplus = /obj/item/bullet_cartridge/rifle_223/nato/surplus

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_2

	icon_states = 1

	value = 10