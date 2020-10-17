/obj/item/magazine/pistol_tranq_11m
	name = "\improper 11.43x25mm tranquilizer magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/tranq.dmi'
	icon_state = "tranq"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/tranq = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/tranq_11m

	bullet_length_min = 23
	bullet_length_best = 25
	bullet_length_max = 26

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	size = SIZE_2

	icon_states = 7

	value = 5