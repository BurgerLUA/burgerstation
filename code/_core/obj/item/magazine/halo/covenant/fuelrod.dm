/obj/item/magazine/halo/covenant/fuel
	name = "\improper fuel rod magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/fuelrod.dmi'
	icon_state = "rod"
	bullet_count_max = 5

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod = TRUE
	)

	ammo = /obj/item/bullet_cartridge/halo/fuelrod

	bullet_length_min = 46
	bullet_length_best = 46
	bullet_length_max = 47

	bullet_diameter_min = 40
	bullet_diameter_best = 41
	bullet_diameter_max = 42

	size = SIZE_2

	icon_states = 5

	value = 2