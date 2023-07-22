/obj/item/magazine/halo/cal30
	name = "\improper .30 Caliber LMG magzine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/30cal.dmi'
	icon_state = "30"
	bullet_count_max = 100

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/rifle_223

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_3

	icon_states = 1

	value = 50