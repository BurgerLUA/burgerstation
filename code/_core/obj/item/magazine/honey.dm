/obj/item/magazine/honey
	name = "\improper .300 CCA magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/honey.dmi'
	icon_state = "honey"

	ammo = /obj/item/bullet_cartridge/honey
	ammo_surplus = /obj/item/bullet_cartridge/honey/surplus

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/honey = TRUE
	)

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_2

	bullet_count_max = 30

	icon_states = 1

	value = 10