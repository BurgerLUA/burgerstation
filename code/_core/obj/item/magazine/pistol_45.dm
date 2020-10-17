/obj/item/magazine/pistol_45
	name = "\improper .45 pistol magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/45pistol.dmi'
	icon_state = "45"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod = TRUE
	)

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	ammo = /obj/item/bullet_cartridge/pistol_45

	size = SIZE_2

	icon_states = 7

	value = 5