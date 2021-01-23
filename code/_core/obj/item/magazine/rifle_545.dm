/obj/item/magazine/rifle_545
	name = "\improper 5.45x39mm magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/545_rifle.dmi'
	icon_state = "545"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/abakan = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak12 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/rifle_545mm

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46

	size = SIZE_2

	icon_states = 1

	value = 10

/obj/item/magazine/rifle_545/ap
	name = "\improper 5.45x39mm AP magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/545_rifle_ap.dmi'
	icon_state = "545"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/abakan = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/ak12 = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/rifle_545mm/ap

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46

	size = SIZE_2

	icon_states = 1

	value = 10