/obj/item/magazine/halo/covenant/needler
	name = "\improper needler magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/needler.dmi'
	icon_state = "needler"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/halo/covenant/needler = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle = TRUE
	)

	ammo = /obj/item/bullet_cartridge/halo/needle

	bullet_length_min = 31
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_2

	icon_states = 1

	value = 40