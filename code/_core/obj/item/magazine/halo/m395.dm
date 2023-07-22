/obj/item/magazine/halo/m395
	name = "\improper M395 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/m395.dmi'
	icon_state = "m395"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395 = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/insurrection = TRUE
	)

	ammo = /obj/item/bullet_cartridge/revolver_762

	bullet_length_min = 36
	bullet_length_best = 38
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2

	icon_states = 1

	value = 75