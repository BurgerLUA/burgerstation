/obj/item/magazine/thompson
	name = "\improper .45 ACP drum magazine."
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/thompson.dmi'
	icon_state = "thompson"
	bullet_count_max = 100 // smg perversion

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/thompson = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_45
	ammo_surplus = /obj/item/bullet_cartridge/pistol_45/surplus

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	size = SIZE_3

	icon_states = 1

	value = 50