/obj/item/magazine/smg_40
	name = "\improper .40 smg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/40smg.dmi'
	icon_state = "40"
	bullet_count_max = 36

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/p69 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

	size = SIZE_2

	icon_states = 12

	value = 10