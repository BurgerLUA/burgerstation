/obj/item/magazine/gauss_gun
	name = "\improper 2.54x12mm Gauss Rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/gauss_gun.dmi'
	icon_state = "fgauss"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/auto = TRUE
	)

	ammo = /obj/item/bullet_cartridge/gauss
	ammo_surplus = /obj/item/bullet_cartridge/gauss/surplus

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 14

	bullet_diameter_min = 1
	bullet_diameter_best = 2.54
	bullet_diameter_max = 3

	size = SIZE_2

	icon_states = 8

	value = 20

/obj/item/magazine/gauss_gun/explosive
	name = "\improper 2.54x12mm Gauss Rifle magazine - Gibtonite Slug"
	icon_state = "fgausshe"
	ammo = /obj/item/bullet_cartridge/gauss/explosive

/obj/item/magazine/gauss_gun/ion
	name = "\improper 2.54x12mm Gauss Rifle magazine - Uranium-Iron Alloy"
	icon_state = "fgaussion"
	ammo = /obj/item/bullet_cartridge/gauss/ion

/obj/item/magazine/gauss_gun/incendiary
	name = "\improper 2.54x12mm Gauss Rifle magazine - Compressed Napalm"
	icon_state = "fgaussinc"
	ammo = /obj/item/bullet_cartridge/gauss/incendiary

/obj/item/magazine/gauss_gun/ap
	name = "\improper 2.54x12mm Gauss Rifle magazine - Depleted Uranium"
	icon_state = "fgaussap"
	ammo = /obj/item/bullet_cartridge/gauss/ap