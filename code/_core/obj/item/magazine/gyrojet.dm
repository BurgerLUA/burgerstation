/obj/item/magazine/gyrojet
	name = "\improper 20mm gyrojet magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/gyrojet.dmi'
	icon_state = "gyrojet"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet = TRUE
	)

	ammo = /obj/item/bullet_cartridge/gyrojet

	bullet_length_min = 48
	bullet_length_best = 50
	bullet_length_max = 52

	bullet_diameter_min = 19
	bullet_diameter_best = 20
	bullet_diameter_max = 21

	size = SIZE_2

	icon_states = 1

	value = 10