/obj/item/magazine/lmg_223
	name = "\improper .223 lmg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/223_lmg.dmi'
	icon_state = "223"
	bullet_count_max = 60

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_223

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_3

	icon_states = 11

	value = 30