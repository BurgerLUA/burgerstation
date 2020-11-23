/obj/item/magazine/dynamic_50
	name = "\improper .50 dynamic revolver magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/dynamic_revolver.dmi'
	icon_state = "dynamic"
	bullet_count_max = 6

	bullet_length_min = 30
	bullet_length_best = 33
	bullet_length_max = 36

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/dynamic = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/pistol_50

	size = SIZE_2

	icon_states = 6

	value = 10