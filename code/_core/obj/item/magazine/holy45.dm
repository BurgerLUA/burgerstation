/obj/item/magazine/holy45
	name = "\improper Holy .45 pistol magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/holy45.dmi'
	icon_state = "holy45"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/holy45 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/pistol_45holy/
	ammo_surplus = /obj/item/bullet_cartridge/pistol_45holy/surplus

	bullet_length_min = 20
	bullet_length_best = 24
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.77
	bullet_diameter_max = 11.77

	size = SIZE_2

	icon_states = 7

	value = 5