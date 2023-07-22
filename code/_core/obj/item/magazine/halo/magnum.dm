/obj/item/magazine/halo/magnum_socom
	name = "\improper M6S Magnum magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/m6c.dmi'
	icon_state = "SOCOMmag"
	bullet_count_max = 12

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom = TRUE
	)

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	ammo = /obj/item/bullet_cartridge/pistol_45

	size = SIZE_1

	icon_states = 1

	value = 5

/obj/item/magazine/halo/magnum_police
	name = "\improper M6B Magnum magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/m6b.dmi'
	icon_state = "m6b"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm/ap

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	size = SIZE_1

	icon_states = 1

	value = 5

/obj/item/magazine/halo/magnum_reach
	name = "\improper M6G Magnum magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/m6b.dmi'
	icon_state = "m6b"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm/ap

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	size = SIZE_1

	icon_states = 1

	value = 5