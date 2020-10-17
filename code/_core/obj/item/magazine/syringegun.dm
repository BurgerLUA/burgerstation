/obj/item/magazine/syringe_gun
	name = "\improper syringe gun magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/syringegun.dmi'
	icon_state = "syringe"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/syringe = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/syringe_gun/

	bullet_length_min = 18.5
	bullet_length_best = 18.5
	bullet_length_max = 18.5

	bullet_diameter_min = 18.5
	bullet_diameter_best = 18.5
	bullet_diameter_max = 18.5

	size = SIZE_2

	icon_states = 8

	value = 20