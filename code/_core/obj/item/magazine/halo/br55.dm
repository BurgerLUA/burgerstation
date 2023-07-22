/obj/item/magazine/halo/br55
	name = "\improper BR55 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/br55.dmi'
	icon_state = "br55"
	bullet_count_max = 36

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/br55 = TRUE,
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

	value = 60