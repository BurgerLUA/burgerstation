/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/45smg.dmi'
	icon_state = "mag"
	bullet_count_max = 36

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_45

	size = SIZE_2

	icon_states = 12

	value = 10

/obj/item/magazine/smg_45/ap
	name = "\improper .45 AP smg magazine"
	ammo = /obj/item/bullet_cartridge/pistol_45/ap