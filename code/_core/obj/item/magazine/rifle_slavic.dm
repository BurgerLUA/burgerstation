/obj/item/magazine/rifle_939
	name = "\improper 9x39mm magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/939.dmi'
	icon_state = "939"

	ammo = /obj/item/bullet_cartridge/rifle_939mm
	ammo_surplus = /obj/item/bullet_cartridge/rifle_939mm/surplus

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/val = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza/equipped = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/an94 = TRUE
	)

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_2


	bullet_count_max = 20

	icon_states = 1

	value = 10