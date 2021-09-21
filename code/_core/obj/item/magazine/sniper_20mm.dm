/obj/item/magazine/sniper_20mm
	name = "\improper 20x117mm sniper magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/20mm_sniper.dmi'
	icon_state = "20"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/sniper_20
	ammo_surplus = /obj/item/bullet_cartridge/sniper_20/surplus

	bullet_length_min = 110
	bullet_length_best = 117
	bullet_length_max = 120

	bullet_diameter_min = 19
	bullet_diameter_best = 20
	bullet_diameter_max = 21

	size = SIZE_2

	icon_states = 1

	value = 40