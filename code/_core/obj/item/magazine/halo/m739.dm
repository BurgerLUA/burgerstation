/obj/item/magazine/halo/m739
	name = "\improper M739 LMG magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/m739.dmi'
	icon_state = "739"
	bullet_count_max = 150

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m739 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/rifle_223/nato

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_4

	icon_states = 1

	value = 80