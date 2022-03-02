/obj/item/magazine/smg_4mm_standard
	name = "\improper 4.6x30mm NanoTech magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/9mm_smg.dmi'
	icon_state = "9mm"
	bullet_count_max = 40

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_4mm/

	ammo_surplus = /obj/item/bullet_cartridge/pistol_4mm/surplus

	size = SIZE_2

	icon_states = 14

	value = 10