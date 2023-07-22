/obj/item/magazine/halo/ma5p
	name = "\improper pulse rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/ma5p.dmi'
	icon_state = "ma5p"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5p = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pulse

	bullet_length_min = 52
	bullet_length_best = 52
	bullet_length_max = 52

	bullet_diameter_min = 13
	bullet_diameter_best = 13
	bullet_diameter_max = 13

	size = SIZE_2

	icon_states = 1

	value = 200